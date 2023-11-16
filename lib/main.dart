import 'package:chat_client_app/core/presentation/app_colors.dart';
import 'package:chat_client_app/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:chat_client_app/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.startup();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
      theme: ThemeData(
        primaryColor: AppColors.appColor,
        primarySwatch: AppColors.appColor
      ),
    );
  }
}
