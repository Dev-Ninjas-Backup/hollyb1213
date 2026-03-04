class ApiEndpoint {
  static const String baseUrl = 'http://10.10.10.64:5056/api/v1';

  // Auth
  static const String uploadUtilityBill = "/profile/documents/utility-bill";
  static const String register = "/auth/register";
  static const String verifyOtp = "/auth/verify-otp";
  static const String resendOtp = "/auth/resend-otp";
  static const String login = 'auth/login';
  static const String employeeJobs = '/employee/jobs';
  static const String employeeLatestJobs = '/employee/latest-jobs';
  static const String employeeAppliedJobs = '/employee/jobs/applied';

  static String employeeJobDetails(String jobId) => '/employee/jobs/$jobId';

  // Employer
  static const String employerUploadProfilePhoto =
      '$baseUrl/profile/documents/profile-photo';
  static const String employerUploadNidPhoto = '$baseUrl/profile/documents/nid';
  static const String employerUploadPassportPhoto =
      '$baseUrl/profile/documents/passport';
  static const String employerUploadUtilityBill =
      '$baseUrl/profile/documents/utility-bill';
  static const String getStripePublishKey =
      '$baseUrl/subscription/payment/config';
  static const String stripePayment = '$baseUrl/subscription/payment/process';
  static const String profilePhoto = '/profile/documents/profile-photo';
  static const String uploadNid = '/profile/documents/nid';
  static const String uploadPassport = '/profile/documents/passport';
  static const String getProfile = '/profile/get-me';
  static const String createJobPost = '/employer/job/create';

  static String getMyPostedJobs(
          String status, bool isUrgent, int page, int limit) =>
      '/employer/jobs?status=$status&is_urgent=$isUrgent&page=$page&limit=$limit';
  static String getJobDetails(String id) => '/employer/jobs/$id';

  static const String employerProfile = '/profile/get-me';
}
