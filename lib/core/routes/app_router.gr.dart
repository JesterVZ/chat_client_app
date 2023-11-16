// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChatPage(
          key: args.key,
          theme: args.theme,
          action: args.action,
        ),
      );
    },
    ThemesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ThemesPage(),
      );
    },
  };
}

/// generated route for
/// [ChatPage]
class ChatRoute extends PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    Key? key,
    required TalkTheme theme,
    required ThemeAction action,
    List<PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            key: key,
            theme: theme,
            action: action,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const PageInfo<ChatRouteArgs> page = PageInfo<ChatRouteArgs>(name);
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    required this.theme,
    required this.action,
  });

  final Key? key;

  final TalkTheme theme;

  final ThemeAction action;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, theme: $theme, action: $action}';
  }
}

/// generated route for
/// [ThemesPage]
class ThemesRoute extends PageRouteInfo<void> {
  const ThemesRoute({List<PageRouteInfo>? children})
      : super(
          ThemesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ThemesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
