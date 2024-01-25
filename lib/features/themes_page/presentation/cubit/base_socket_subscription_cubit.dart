import 'dart:async';

import 'package:chat_client_app/core/socket/chat_subscription_websocket_channel.dart';
import 'package:chat_client_app/core/socket/web_socket_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Базовый кубит для подключения и работы с WebSocket
/// Позволяет подписываться и отписываться

abstract class BaseSocketSubscriptionCubit<State extends BaseSocketSubscriptionState> extends Cubit<State>{
  BaseSocketSubscriptionCubit(State initialState, this.url):super(initialState){
    _initSocketConnection();
  }
  final String url;
  ChatSubscriptionWebSocketChannel? webSocket;
  StreamSubscription<WebSocketState>? webSocketStateSubscription;
  StreamSubscription? receivedSubscribedEventsSubscription;

  void send({required String event, required dynamic message}){
    webSocket!.send(event: event, message: message);
  }


  Future<void> _initSocketConnection() async {
    if (state.isConnectionEstablished) {
      return;
    }
    webSocket ??= ChatSubscriptionWebSocketChannel(url: url);
    try {
      await webSocket!.connect();
    } catch (ex, stacktrace) {
      addError(ex, stacktrace);
    }
    webSocketStateSubscription = webSocket!.stateStream.listen(onWebSocketStateUpdate);
    receivedSubscribedEventsSubscription = webSocket!.receivedSubscriptionMessages.listen(onReceivedSubscribedEvent);

  }

  void onWebSocketStateUpdate(WebSocketState wsState) {
    switch (wsState) {
      case WebSocketState.connected:
        emit(state.copyWith(isConnectionEstablished: true) as State);
        break;
      case WebSocketState.awaitingNetworkAvailability:
        emit(state.copyWith(isConnectionEstablished: false) as State);
        break;
      case WebSocketState.disconnected:
        emit(state.copyWith(isConnectionEstablished: false) as State);
        // Пытаемся установить сокет соединение снова
        _initSocketConnection();
        break;
      case WebSocketState.initial:
      case WebSocketState.connecting:
        break;
    }
  }
  /// Вызывается при получении евента от сокет соединения.
  void onReceivedSubscribedEvent(dynamic eventJson);

  Future<void> _closeSocketConnection() async {}

  Future<void> _cancelSubscriptions() async => await Future.wait([
        if (webSocketStateSubscription != null) webSocketStateSubscription!.cancel(),
        if (receivedSubscribedEventsSubscription != null) receivedSubscribedEventsSubscription!.cancel()
      ]);

  @override
  Future<void> close() {
    _closeSocketConnection();
    _cancelSubscriptions();
    return super.close();
  }
}

class BaseSocketSubscriptionState extends Equatable {
  const BaseSocketSubscriptionState({this.isConnectionEstablished = false});


  final bool isConnectionEstablished;

  @override
  List<Object?> get props => [isConnectionEstablished];

  BaseSocketSubscriptionState copyWith({bool? isConnectionEstablished}) =>
      BaseSocketSubscriptionState(
          isConnectionEstablished: isConnectionEstablished ?? this.isConnectionEstablished);
}