class Endpoint {
  static const String baseUrl =
      'https://wiley-half-nonhabitably.ngrok-free.dev/api/v1';

  // --- Auth Endpoints ---
  static const String register = '$baseUrl/auth/register';
  static const String verifyOtp = '$baseUrl/auth/verify-otp';
  static const String resendOtp = '$baseUrl/auth/resend-otp';
  static const String login = '$baseUrl/auth/login';
}
