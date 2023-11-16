import 'package:auto_route/annotations.dart';
import 'package:chat_client_app/core/presentation/app_ui.dart';
import 'package:chat_client_app/di/injection_container.dart';
import 'package:chat_client_app/features/themes_page/data/theme_actioons.dart';
import 'package:chat_client_app/features/themes_page/data/websocket/talk_theme.dart';
import 'package:chat_client_app/features/themes_page/presentation/cubit/chat_subscription_cubit.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  final TalkTheme theme;
  final ThemeAction action;
  const ChatPage({ Key? key, required this.theme, required this.action}) : super(key: key);

  @override
  State createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ThemeSubscriptionCubit _chatSubscriptionCubit;

  @override
  void dispose() {
    _chatSubscriptionCubit.deleteTheme(talkTheme: _chatSubscriptionCubit.state.getSelectedTheme!);
    super.dispose();
  }

  @override
  void initState() {
    _chatSubscriptionCubit = locator.get<ThemeSubscriptionCubit>();
    switch(widget.action){
      case ThemeAction.create:
      _chatSubscriptionCubit.addNewTheme(talkTheme: widget.theme);
      break;
      case ThemeAction.select:
      _chatSubscriptionCubit.selectTheme(talkTheme: widget.theme);
      break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const Column(
        children: [

        ],
      ),
    );
  }

  AppBar _buildAppBar() => AppUI.appBar(title: Text(widget.theme.getTitle));
}