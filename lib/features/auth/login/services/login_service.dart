import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';

class LoginService extends GetConnect {
  // final String _baseUrl =
  //     'https://wiley-half-nonhabitably.ngrok-free.dev/api/v1';

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    final response = await post(
      '${ApiEndpoint.baseUrl}/auth/login',
      {'email': email, 'password': password},
      headers: {'Content-Type': 'application/json'},
    );
    // ignore: avoid_print
    print('Login API Response: ${response.body}');
    return response;
  }
}
