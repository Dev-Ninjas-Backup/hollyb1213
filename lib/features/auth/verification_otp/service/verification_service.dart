// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/api_endpoint.dart';

class VerificationService extends GetConnect {
  Future<Response> verifyOtp({
    required String email,
    required String code,
  }) async {
    final response = await post(
      '${ApiEndpoint.baseUrl}/auth/verify-otp',
      {'email': email, 'code': code},
      headers: {'Content-Type': 'application/json'},
    );
    print('OTP Verification request sent for email: $email with code: $code');
    return response;
  }

  Future<Response> resendOtp({required String email}) async {
    final response = await post(
      '${ApiEndpoint.baseUrl}/auth/resend-otp',
      {'email': email},
      headers: {'Content-Type': 'application/json'},
    );
    print('Resend OTP request sent for email: $email');

    return response;
  }
}
