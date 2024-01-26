import 'dart:async';
import 'dart:convert';

import 'package:chat_client_app/core/app.dart';
import 'package:chat_client_app/core/socket/web_socket_state.dart';
import 'package:chat_client_app/core/utils/exceptions.dart';
import 'package:chat_client_app/features/themes_page/data/websocket/talk_theme.dart';
import 'package:chat_client_app/features/themes_page/data/websocket/user_connect.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatSubscriptionWebSocketChannel{
  ChatSubscriptionWebSocketChannel({required this.url, this.reconnectDelay = defaultReconnectDelay,});

  /// Задержка между двумя попытками переподключения
  static const defaultReconnectDelay = Duration(seconds: 5);
  final String url;
  final Duration reconnectDelay;

  ValueStream<WebSocketState> get stateStream => _stateStream.stream;

  WebSocketState get state => stateStream.value;

  /// Максимальное количество переподключения
  static const maxReconnectTries = 10;

  /// Максимальное количество попыток отправки события по сокету
  static const maxResendTries = 10;

  /// Стрим полученных из сокет соединения сообщений, на которые мы подписались с помощью subscribe.
  /// Возвращает json мапу
  ValueStream get receivedSubscriptionMessages => _themesSubscriptionMessages.stream;

  ValueStream get chatSubscriptionMessages => _chatSubscriptionMessages.stream;

  Future<void> connect() async {
    if (state == WebSocketState.initial || state == WebSocketState.disconnected) {
      _reconnectTries = 0;
      _state = WebSocketState.connecting;
    }
    await _socketSubscription?.cancel();

    try{
      _channel = io(App.wsUrl, OptionBuilder().setTransports(['websocket']).build());
      _channel!.connect();
    } catch (ex) {
      print(
        '$url: Критическая ошибка при попытке установить с сокетом соединение, '
        'попытка #$_reconnectTries $ex'
      );
      unawaited(_reconnect());
      throw SocketConnectionFailedException(
        url,
        'Критическая ошибка при попытке установить соединение, попытка #$_reconnectTries',
      );
    }

    _channel!.on('themes', (data) => _themesSubscriptionMessages.add(data));
    _channel!.on('createdTheme', (data) => _themesSubscriptionMessages.add(TalkTheme.fromJson(jsonDecode(jsonEncode(data)))));
    _channel!.on('join', (data) => _themesSubscriptionMessages.add(UserJoinedInRoom(id: data)));
    _channel!.on('messages', (data) => _themesSubscriptionMessages.add(UserJoinedInRoom(id: data)));
  }

  /// Закрываем соединение. Можно будет перезапустить с помощью connect
  Future<void> close() async {
    assert(
      state != WebSocketState.disconnected,
      'InstrumentSubscriptionWebSocketChannel.close не может быть вызван на инстансе с состоянием '
      'WebSocketState.disconnected',
    );
    await _socketSubscription?.cancel();
    _channel?.close();
    _state = WebSocketState.disconnected;
  }

  Future<void> _reconnect() async {
    await Future.delayed(reconnectDelay);
    if (state == WebSocketState.disconnected) return;

    _state = WebSocketState.connecting;
    _reconnectTries += 1;
    if (_reconnectTries > maxReconnectTries) {
      unawaited(close());
      throw SocketConnectionFailedException(url, 'Достигнут лимит попыток соединения с сокетом');
    }

    await connect();

    final currentReconnectTries = _reconnectTries;
    // Делаем проверку с задержкой чтобы убедиться,
    // что соединение установлено успешно и не разорволось снова через 5 секунд
    // Если разорвется, то мы не должны сбрасывать количество попыток переподключения
    Future.delayed(const Duration(seconds: 5), () {
      if (currentReconnectTries == _reconnectTries) {
        _reconnectTries = 0;
        _state = WebSocketState.connected;
      }
    });
  }

  void send({required String event, required dynamic message}){
    _channel!.emit(event, message);
  }
  
  /// Текущее количество неудачных попыток переподключения к сокету подряд.
  /// Сбрасываем при удачном подключении
  /// При достижении [maxReconnectTries] прекращаем пытаться переподключиться автоматически
  int _reconnectTries = 0;

  final _stateStream = BehaviorSubject<WebSocketState>.seeded(WebSocketState.initial);
  final _themesSubscriptionMessages = BehaviorSubject();
  final _chatSubscriptionMessages = BehaviorSubject();
  set _state(WebSocketState state) => _stateStream.add(state);

  Socket? _channel;
  StreamSubscription? _socketSubscription;
}