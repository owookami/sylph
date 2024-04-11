import 'package:get/get.dart';
import 'package:sylph/app/backend/binding/splash_binding.dart';
import 'package:sylph/app/backend/binding/tabs_binding.dart';
import 'package:sylph/app/view/homse_screen.dart';
import 'package:sylph/app/view/spalsh_screen.dart';
import 'package:sylph/app/view/tab_screen.dart';

class AppRouter {
  static const String initial = '/';
  static const String tabs = '/tabs';
  static const String home = '/home';

  static String getInitialRoute() => initial;
  static String getTabRoute() => tabs ;
  static String getHomeRoute() => home ;

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => const SplashScreen(),
      binding: SplashBinding()
    ),
    GetPage(
        name: tabs,
        page: () => const TabsScreen(),
        binding: TabsBindings(),
    ),
  ];


}