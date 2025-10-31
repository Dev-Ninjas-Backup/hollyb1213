import 'package:get/get_navigation/get_navigation.dart';
import 'package:hollyb1213/features/auth/create_new_password/screen/create_password_screen.dart';
import 'package:hollyb1213/features/auth/forgot_password/screen/forgot_password_screen.dart';
import 'package:hollyb1213/features/auth/forgot_password_otp/screen/otp_screen.dart';
import 'package:hollyb1213/features/auth/login/screen/login_screen.dart';
import 'package:hollyb1213/features/auth/payment_method/screen/payment_method_screen.dart';
import 'package:hollyb1213/features/auth/role_selection/screen/role_selection_screen.dart';
import 'package:hollyb1213/features/auth/sing_up/screen/sing_up_screen.dart';
import 'package:hollyb1213/features/auth/upload_nid/screen/upload_nid_screen.dart';
import 'package:hollyb1213/features/auth/upload_passport/screen/upload_passport_screen.dart';
import 'package:hollyb1213/features/auth/upload_profile/screen/upload_profile_screen.dart';
import 'package:hollyb1213/features/auth/upload_utility_bill/screen/upload_utility_bill_screen.dart';
import 'package:hollyb1213/features/auth/verification_otp/screen/verification_screen.dart';
import 'package:hollyb1213/features/employee/bottom_navbar/screen/employee_bottom_navbar_screen.dart';
import 'package:hollyb1213/features/employee/home/job_details/screen/job_details_screen.dart';
import 'package:hollyb1213/features/employee/home/screen/employe_home_screen.dart';
import 'package:hollyb1213/features/employee/jobs/screen/employee_jobs_screen.dart';
import 'package:hollyb1213/features/employee/profile_screen/privacy/employee_privacy.dart';
import 'package:hollyb1213/features/employee/profile_screen/review/screen/employee_review_page.dart';
import 'package:hollyb1213/features/employer/bottom_navbar/screen/employer_bottom_navbar_screen.dart';

import 'package:hollyb1213/features/employer/create_post/screen/create_post_screen.dart';

import 'package:hollyb1213/features/employer/profile_screen/profile/screen/employer_profile_screen.dart';

import 'package:hollyb1213/features/onboarding/screen/onboarding_screen.dart';

import '../features/employee/profile_screen/profile_info/screen/employee_profile_info_page.dart';

class AppRoute {
  //employer
  static String employerBottomNavbarScreen = '/employerBottomNavbarScreen';

  static String createPostScreen = '/createPostScreen';

  static String employerProfileScreen = '/employerProfileScreen';


  //employee
  static String roleSelectionScreen = '/roleSelectionScreen';
  static String onboardingScreen = '/onboardingScreen';
  static String loginScreen = '/loginScreen';
  static String forgotPasswordScreen = '/forgotPasswordScreen';
  static String otpScreen = '/otpScreen';
  static String createPasswordScreen = '/createPasswordScreen';
  static String singUpScreen = '/singUpScreen';
  static String verificationScreen = '/verificationScreen';
  static String uploadProfileScreen = '/uploadProfileScreen';
  static String uploadNidScreen = '/uploadNidScreen';
  static String uploadPassportScreen = '/uploadPassportScreen';
  static String uploadUtilityBillScreen = '/uploadUtilityBillScreen';
  static String paymentMethodScreen = '/paymentMethodScreen';
  static String employeeBottomNavbarScreen = '/employeeBottomNavbarScreen';
  static String employeeHomeScreen = '/employeeHomeScreen';

  static String jobDetailsScreen = '/jobDetailsScreen';

  //profile
  static String employeeProfileInfo = "/employee/employeeProfileInfo";
  static String employeeprivacy = "/employee/privacy";
  static String employeeReview = "/emplyee/employeeReview";

  static String employeeAvailablejobs = '/employeeAvailablejobs';

  //employer

  static String getemployerBottomNavbarScreen = employerBottomNavbarScreen;
  static String getcreatePostScreen() => createPostScreen;

  static String getemployerBottomNavbarScreen() => employerBottomNavbarScreen;
  static String getemployerProfileScreen() => employerProfileScreen;

  //employee
  static String getroleSelection() => roleSelectionScreen;
  static String getonboardingScreen() => onboardingScreen;
  static String getloginScreen() => loginScreen;
  static String getforgotPasswordScreen() => forgotPasswordScreen;
  static String getotpScreen() => otpScreen;
  static String getcreatePasswordScreen() => createPasswordScreen;
  static String getsingUpScreen() => singUpScreen;
  static String getverificationScreen() => verificationScreen;
  static String getuploadProfileScreen() => uploadProfileScreen;
  static String getuploadNidScreen() => uploadNidScreen;
  static String getuploadPassportScreen() => uploadPassportScreen;
  static String getuploadUtilityBillScreen() => uploadUtilityBillScreen;
  static String getpaymentMethodScreen() => paymentMethodScreen;
  static String getEmployeeBottomNavbarScreen() => employeeBottomNavbarScreen;
  static String getEmployeeHomeScreen() => employeeHomeScreen;
  static String getemployeeReview() => employeeReview;

  static String getjobDetailsScreen() => jobDetailsScreen;

  static String getemployeeProfileInfo() => employeeProfileInfo;
  static String getEmployreeprivacy() => employeeprivacy;
  static String getEmployeeAvailableJobs() => employeeAvailablejobs;

  static List<GetPage> routes = [
    GetPage(
      name: roleSelectionScreen,
      page: () => RoleSelectionScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: createPostScreen,
      page: () => CreatePostScreen(),
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
    GetPage(
      name: uploadProfileScreen,
      page: () => UploadProfileScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: uploadNidScreen,
      page: () => UploadNidScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: uploadPassportScreen,
      page: () => UploadPassportScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: uploadUtilityBillScreen,
      page: () => UploadUtilityBillScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: paymentMethodScreen,
      page: () => PaymentMethodScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: employeeBottomNavbarScreen,
      page: () => EmployeeBottomNavbarScreen(),
    ),
    GetPage(
      name: employeeHomeScreen,
      page: () => EmployeHomeScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: jobDetailsScreen,
      page: () => JobDetailsScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(name: employeeProfileInfo, page: () => EmployeeProfileInfoPage()),
    GetPage(name: employeeprivacy, page: () => EmployeePrivacy()),
    GetPage(name: employeeReview, page: () => EmployeeReviewPage()),

    GetPage(name: employeeAvailablejobs, page: () => JobScreen()),

    //employer
    GetPage(
      name: employerBottomNavbarScreen,
      page: () => EmployerBottomNavbarScreen(),
    ),


    GetPage(name: employerProfileScreen, page: () => EmployerProfileScreen()),

  ];
}
