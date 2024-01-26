import 'dart:convert';

import 'package:chat_client_app/core/app.dart';
import 'package:chat_client_app/features/themes_page/data/websocket/talk_theme.dart';
import 'package:chat_client_app/features/themes_page/domain/cubit/base_socket_subscription_cubit.dart';
import 'package:chat_client_app/features/chat_page/domain/cubit/chat_subscription_cubit.dart';

class ThemeSubscriptionCubit extends BaseSocketSubscriptionCubit<ThemeSubscriptionState>{
  ThemeSubscriptionCubit({required this.chatSubscriptionCubit}):super(const ThemeSubscriptionState(), App.wsUrl);
  final ChatSubscriptionCubit chatSubscriptionCubit;
  
  @override
  void onReceivedSubscribedEvent(dynamic eventJson) {
    try{
      if(eventJson is TalkTheme){
        emit(state.copyWith(selectTheme: eventJson) as ThemeSubscriptionState);
        chatSubscriptionCubit.initChat(currentId: state.getSelectedTheme!.id!);
        return;
      }
      final List jsonList = jsonDecode(jsonEncode(eventJson));
      final List<TalkTheme> themes = jsonList.map((e) => TalkTheme.fromJson(e)).toList();
      emit(state.copyWith(themes: themes, json: eventJson.toString()) as ThemeSubscriptionState);
    }catch(_){
      
    }
    
  }

  void addNewTheme({required TalkTheme talkTheme}){
    send(event: 'addNewTheme', message: talkTheme);
  }

  void selectTheme({required TalkTheme talkTheme}){
    send(event: 'selectTheme', message: talkTheme.id);
  }

  void deleteTheme({required TalkTheme talkTheme}){
    send(event: 'deleteTheme', message: talkTheme.id);
  }

}


class ThemeSubscriptionState extends BaseSocketSubscriptionState{
  final List<TalkTheme> _themes;
  final String _json;
  final TalkTheme? _selectedTheme;
  const ThemeSubscriptionState({List<TalkTheme> themes = const[], String json = "", bool isConnectionEstablished = false, TalkTheme? selectTheme}) : _themes = themes, _json = json, _selectedTheme = selectTheme, super(isConnectionEstablished: isConnectionEstablished);

  List<TalkTheme> get getThemes => _themes;

  String get getJson => _json;

  TalkTheme? get getSelectedTheme => _selectedTheme;

  @override
  List<Object?> get props => [...super.props, _themes, _json, _selectedTheme];

  @override
  BaseSocketSubscriptionState copyWith({List<TalkTheme>? themes, String? json, bool? isConnectionEstablished, TalkTheme? selectTheme}) => ThemeSubscriptionState(themes: themes ?? _themes, json: json ?? _json, selectTheme: selectTheme);

}