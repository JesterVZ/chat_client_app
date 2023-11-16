import 'package:chat_client_app/core/domain/callback.dart';
import 'package:chat_client_app/core/presentation/app_colors.dart';
import 'package:chat_client_app/features/themes_page/data/websocket/talk_theme.dart';
import 'package:flutter/material.dart';

class ThemeWidget extends StatelessWidget {
  final TalkTheme theme;
  final ChangeThemeClick onClick;
  const ThemeWidget({Key? key, required this.theme, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onClick.call(theme),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14), color: AppColors.appColor),
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Text(
                      theme.title ?? "нет названия",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
