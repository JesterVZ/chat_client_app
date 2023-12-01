import 'package:auto_route/auto_route.dart';
import 'package:chat_client_app/features/themes_page/data/theme_actioons.dart';
import 'package:chat_client_app/features/themes_page/data/websocket/talk_theme.dart';
import 'package:chat_client_app/features/chat_page/presentation/chat_page.dart';
import 'package:chat_client_app/features/themes_page/presentation/pages/themes_page.dart';
import 'package:flutter/widgets.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    RedirectRoute(path: '/', redirectTo: '/themes'),
        AutoRoute(
          page: ThemesRoute.page,
          path: '/themes',
        ),
        AutoRoute(
          page: ChatRoute.page,
          path: '/chat',
        ),
      ];
}