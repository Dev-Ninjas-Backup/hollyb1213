class ApiEndpoint {
  static const String baseUrl =
      'https://wiley-half-nonhabitably.ngrok-free.dev/api/v1';

  // Auth
  static const String login = 'auth/login';
  static const String employeeJobs = 'employee/jobs';
  static const String employeeLatestJobs = 'employee/latest-jobs';
  static const String employeeAppliedJobs = 'employee/jobs/applied';

  static String employeeJobDetails(String jobId) => 'employee/jobs/$jobId';
}
