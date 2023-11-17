import 'package:chat_client_app/features/themes_page/presentation/cubit/chat_subscription_cubit.dart';
import 'package:chat_client_app/features/themes_page/presentation/cubit/theme_subscription_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> startup() async {
  locator.registerLazySingleton(() => ChatSubscriptionCubit());
  locator.registerLazySingleton(() => ThemeSubscriptionCubit(chatSubscriptionCubit: locator()));
  
}