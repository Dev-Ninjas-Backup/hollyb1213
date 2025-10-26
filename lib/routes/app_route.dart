import 'package:get/get_navigation/get_navigation.dart';
import 'package:hollyb1213/features/auth/role_selection/screen/role_selection_screen.dart';
import 'package:hollyb1213/features/onboarding/screen/onboarding_screen.dart';

class AppRoute {
  static String roleSelectionScreen = '/roleSelectionScreen';
  static String onboardingScreen = '/onboardingScreen';

  static String getroleSelection() => roleSelectionScreen;
  static String getonboardingScreen() => onboardingScreen;

  static List<GetPage> routes = [
    GetPage(
      name: roleSelectionScreen,
      page: () => RoleSelectionScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: onboardingScreen,
      page: () => OnboardingScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
