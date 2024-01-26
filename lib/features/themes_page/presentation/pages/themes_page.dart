import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:chat_client_app/core/presentation/app_ui.dart';
import 'package:chat_client_app/core/routes/app_router.dart';
import 'package:chat_client_app/di/injection_container.dart';
import 'package:chat_client_app/features/themes_page/data/theme_actioons.dart';
import 'package:chat_client_app/features/themes_page/data/websocket/talk_theme.dart';
import 'package:chat_client_app/features/themes_page/domain/cubit/theme_subscription_cubit.dart';
import 'package:chat_client_app/features/themes_page/presentation/widgets/theme_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ThemesPage extends StatefulWidget {
  const ThemesPage({Key? key}) : super(key: key);

  @override
  State createState() => _ThemesPageState();
}

class _ThemesPageState extends State<ThemesPage> {
  late ThemeSubscriptionCubit _chatSubscriptionCubit;
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _chatSubscriptionCubit = locator.get<ThemeSubscriptionCubit>();
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<ThemeSubscriptionCubit, ThemeSubscriptionState>(
          bloc: _chatSubscriptionCubit,
          builder: (context, ThemeSubscriptionState state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 300,
                          child: TextField(
                            key: UniqueKey(),
                            controller: _titleController,
                            decoration:
                                const InputDecoration(hintText: "Введите тему"),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: ElevatedButton(onPressed: () => context.router.push(ChatRoute(theme: TalkTheme(isCanRing: false, title: _titleController.text), action: ThemeAction.create)), child: const Text("Начать диалог")),
                      )
                    ],
                  ),
                ),
                Wrap(
                    children: state.getThemes
                        .map((e) => ThemeWidget(
                              theme: e,
                              onClick: (theme) =>
                                  context.router.push(ChatRoute(theme: theme, action: ThemeAction.select)),
                            ))
                        .toList()),
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() => AppUI.appBar(actions: _buildActions());

  List<Widget> _buildActions() => [
        IconButton(
            onPressed: () {
              _chatSubscriptionCubit.addNewTheme(
                  talkTheme: TalkTheme(title: 'test', isCanRing: false));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            )),
      ];
}
