import 'package:get/get_navigation/get_navigation.dart';
import 'package:hollyb1213/features/auth/create_new_password/screen/create_password_screen.dart';
import 'package:hollyb1213/features/auth/forgot_password/screen/forgot_password_screen.dart';
import 'package:hollyb1213/features/auth/forgot_password_otp/screen/otp_screen.dart';
import 'package:hollyb1213/features/auth/login/screen/login_screen.dart';
import 'package:hollyb1213/features/auth/role_selection/screen/role_selection_screen.dart';
import 'package:hollyb1213/features/auth/sing_up/screen/sing_up_screen.dart';
import 'package:hollyb1213/features/auth/verification_otp/screen/verification_screen.dart';
import 'package:hollyb1213/features/onboarding/screen/onboarding_screen.dart';

class AppRoute {
  static String roleSelectionScreen = '/roleSelectionScreen';
  static String onboardingScreen = '/onboardingScreen';
  static String loginScreen = '/loginScreen';
  static String forgotPasswordScreen = '/forgotPasswordScreen';
  static String otpScreen = '/otpScreen';
  static String createPasswordScreen = '/createPasswordScreen';
  static String singUpScreen = '/singUpScreen';
  static String verificationScreen = '/verificationScreen';

  static String getroleSelection() => roleSelectionScreen;
  static String getonboardingScreen() => onboardingScreen;
  static String getloginScreen() => loginScreen;
  static String getforgotPasswordScreen() => forgotPasswordScreen;
  static String getotpScreen() => otpScreen;
  static String getcreatePasswordScreen() => createPasswordScreen;
  static String getsingUpScreen() => singUpScreen;
  static String getverificationScreen() => verificationScreen;

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
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: otpScreen,
      page: () => OTPScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: createPasswordScreen,
      page: () => CreatePasswordScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: singUpScreen,
      page: () => SingUpScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: verificationScreen,
      page: () => VerificationScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
