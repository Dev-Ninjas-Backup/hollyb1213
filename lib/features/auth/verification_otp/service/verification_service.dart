// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/endpoint.dart';

class VerificationService extends GetConnect {
  // final String _baseUrl =
  //     'https://wiley-half-nonhabitably.ngrok-free.dev/api/v1';

  Future<Response> verifyOtp({
    required String email,
    required String code,
  }) async {
    final response = await post(
      '${Endpoint.baseUrl}/auth/verify-otp',
      {'email': email, 'code': code},
      headers: {'Content-Type': 'application/json'},
    );
    print('OTP Verification request sent for email: $email with code: $code');
    return response;
  }

  Future<Response> resendOtp({required String email}) async {
    final response = await post(
      '${Endpoint.baseUrl}/auth/resend-otp',
      {'email': email},
      headers: {'Content-Type': 'application/json'},
    );
    print('Resend OTP request sent for email: $email');

    return response;
  }
}
