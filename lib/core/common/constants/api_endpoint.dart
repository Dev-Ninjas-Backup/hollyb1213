class ApiEndpoint {
  static const String baseUrl =
      'https://wiley-half-nonhabitably.ngrok-free.dev/api/v1'; // CHANGE THIS to your real API URL

  // Auth
  static const String login = '/auth/login';
  static const String employeeJobs = '/employee/jobs';
  static const String employeeLatestJobs = '/employee/latest-jobs';
  static const String employeeAppliedJobs = '/employee/jobs/applied';
  static String employeeJobDetails(String jobId) => '/employee/jobs/$jobId';
  static const String profilePhoto = "/profile/documents/profile-photo";
  static const String uploadNid = "/profile/documents/nid";
  static const String uploadPassport = "/profile/documents/passport";
  static const String uploadUtilityBill = "/profile/documents/utility-bill";
  static const String register = "/auth/register";
  static const String verifyOtp = "/auth/verify-otp";
  static const String resendOtp = "/auth/resend-otp";
}
