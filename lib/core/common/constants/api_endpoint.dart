class ApiEndpoint {
  static const String baseUrl =
      'https://wiley-half-nonhabitably.ngrok-free.dev/api/v1';

  // Auth
  static const String login = 'auth/login';
  static const String employeeJobs = 'employee/jobs';
  static const String employeeLatestJobs = 'employee/latest-jobs';
  static const String employeeAppliedJobs = 'employee/jobs/applied';

  static String employeeJobDetails(String jobId) => 'employee/jobs/$jobId';

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
}
