import 'package:auto_route/annotations.dart';
import 'package:chat_client_app/core/presentation/app_colors.dart';
import 'package:chat_client_app/core/presentation/app_ui.dart';
import 'package:chat_client_app/core/presentation/widgets/app_progress_indicator.dart';
import 'package:chat_client_app/core/presentation/widgets/widget_ext.dart';
import 'package:chat_client_app/di/injection_container.dart';
import 'package:chat_client_app/features/chat_page/data/websocket/send_message.dart';
import 'package:chat_client_app/features/themes_page/data/theme_actioons.dart';
import 'package:chat_client_app/features/themes_page/data/websocket/talk_theme.dart';
import 'package:chat_client_app/features/themes_page/domain/cubit/base_socket_subscription_cubit.dart';
import 'package:chat_client_app/features/chat_page/domain/cubit/chat_subscription_cubit.dart';
import 'package:chat_client_app/features/themes_page/domain/cubit/theme_subscription_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  final TalkTheme theme;
  final ThemeAction action;
  const ChatPage({Key? key, required this.theme, required this.action})
      : super(key: key);

  @override
  State createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ThemeSubscriptionCubit _themeSubscriptionCubit;
  late ChatSubscriptionCubit _chatSubscriptionCubit;
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    if (_themeSubscriptionCubit.state.getSelectedTheme != null) {
      _themeSubscriptionCubit.deleteTheme(
          talkTheme: _themeSubscriptionCubit.state.getSelectedTheme!);
    }

    super.dispose();
  }

  @override
  void initState() {
    _themeSubscriptionCubit = locator.get<ThemeSubscriptionCubit>();
    _chatSubscriptionCubit = locator.get<ChatSubscriptionCubit>();
    switch (widget.action) {
      case ThemeAction.create:
        _themeSubscriptionCubit.addNewTheme(talkTheme: widget.theme);
        break;
      case ThemeAction.select:
        _themeSubscriptionCubit.selectTheme(talkTheme: widget.theme);
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<ChatSubscriptionCubit, BaseSocketSubscriptionState>(
          bloc: _chatSubscriptionCubit,
          builder: (BuildContext context, state) {
            if (state is UserConnectedState ||
                widget.action == ThemeAction.select) {
              return _buildChatContent();
            } else {
              if(state is UserNotConnectedState){
                widget.theme.id = state.currendThemeId;
              }
              
              return _buildLoading();
            }
          }),
    );
  }

  AppBar _buildAppBar() => AppUI.appBar(title: Text(widget.theme.getTitle));

  Widget _buildLoading() => const Center(
          child: AppProgressIndicator(),
        );
  Widget _buildChatContent() => Column(
        children: [
          Expanded(
              child: ListView(
            children: const [Text("Собеседник найден")],
          )),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            decoration: const BoxDecoration(color: AppColors.appColor),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: (value) {
                      _chatSubscriptionCubit.sendMessage(Message(themeId: widget.theme.getId, message: _messageController.text));
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.white1,
                      
                    ),
                  ).paddingAll(AppUI.paddingXS),
                ),
                
              ],
            ),
          )
        ],
      );
}
