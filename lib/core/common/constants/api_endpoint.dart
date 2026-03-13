class ApiEndpoint {
  static const String baseUrl = 'http://16.16.114.137:5000/api/v1';

  // Auth
  static const String uploadUtilityBill = "/profile/documents/utility-bill";
  static const String register = "/auth/register";
  static const String verifyOtp = "/auth/verify-otp";
  static const String resendOtp = "/auth/resend-otp";
  static const String login = '/auth/login';
  static const String googleLogin = '/auth/google';
  static const String facebookLogin = '/auth/facebook';
  static const String appleLogin = '/auth/apple';
  static const String employeeJobs = '/employee/jobs';
  static const String employeeLatestJobs = '/employee/latest-jobs';
  static const String employeeAppliedJobs = '/employee/jobs/applied';
  static const String employeeStats = '$baseUrl/employee/stats';

  static String employeeJobDetails(String jobId) => '/employee/jobs/$jobId';
  static String applyJob(String jobId) => '/employee/jobs/$jobId/apply';
  static String checkIn(String jobId) => '/employee/jobs/$jobId/check-in';
  static String checkOut(String jobId) => '/employee/jobs/$jobId/check-out';
  static String markAsComplete(String jobId) =>
      '/employee/jobs/$jobId/mark-as-complete';

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
  static const String getProfile = '$baseUrl/profile/get-me';
  static const String changePassword = '/profile/change-password';
  static const String createJobPost = '$baseUrl/employer/job/create';

  static String getMyPostedJobs(
          String status, bool isUrgent, int page, int limit) =>
      '$baseUrl/employer/jobs?status=$status&is_urgent=$isUrgent&page=$page&limit=$limit';
  static String getJobDetails(String id) => '/employer/jobs/$id';

  static const String employerProfile = '$baseUrl/profile/get-me';
  static const String employerStats = '$baseUrl/employer/stats';
  static const String updateEmployerProfile = '$baseUrl/profile/update-me';
  static const String updateEmployeeProfile = '$baseUrl/profile/update-me';
  static const String employerSubscriptionStatus =
      '$baseUrl/subscription/my-subscriptions/current';
  static const String employerRenewSubscription = '$baseUrl/subscription/renew';
  static String getMyPostedJobsHomeScreen(String status, int page, int limit) =>
      '$baseUrl/employer/jobs?status=$status&page=$page&limit=$limit';
  static String seeFavoriteEmployeeList(int page, int limit) =>
      '$baseUrl/employer/favorites?page=$page&limit=$limit';
  static String addEmployeeAsFavorite = '$baseUrl/employer/favorites';
  static String rateJob(String id) => '$baseUrl/employer/review/create/$id';
  static String removeEmployeeFromFavorites(String employeeId) =>
      '$baseUrl/employer/favorites/$employeeId';
  static String checkEmployeeIfFavorite(String employeeId) =>
      '$baseUrl/employer/favorites/$employeeId/check';
  static String getAllJobs2(int page, int limit) =>
      '$baseUrl/employer/jobs?page=$page&limit=$limit';
  static String viewAllApplicationts(String jobId) =>
      '$baseUrl/employer/jobs/$jobId/applications';
  static String acceptApplicant(String applicationId) =>
      '$baseUrl/employer/applications/$applicationId/accept';
  static String rejectApplicant(String applicationId) =>
      '$baseUrl/employer/applications/$applicationId/reject';
  static String viewEmployeeProfile(String employeeId) =>
      '$baseUrl/employer/employees/$employeeId';
  static String seeAllReviews(String employeeId, int page, int limit) =>
      '$baseUrl/employer/reviews?page=$page&limit=$limit&employeeId=$employeeId';

  // Notifications
  static String getUserNotifications(String userId) =>
      '$baseUrl/notification/user/$userId';
  static String markNotificationAsRead(String notificationId) =>
      '$baseUrl/notification/$notificationId/read';
  static String deleteUserProfile = '$baseUrl/profile/delete';
  static const String conversations = '/private-message/conversations';

  static String getConversationDetails(String conversationId) =>
      '/private-message/conversations/$conversationId';
}
