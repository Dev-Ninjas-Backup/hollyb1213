import 'package:get/get_navigation/get_navigation.dart';
import 'package:hollyb1213/features/splash/screen/splash_screen.dart';

class AppRoute {
  static String splashScreen = '/splashScreen';
  static String getSplashScreen() => splashScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
  ];
}
