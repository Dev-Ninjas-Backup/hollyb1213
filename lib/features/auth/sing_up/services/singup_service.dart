import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';

class SingupService extends GetConnect {
  Future<Response> register({
    required String fullName,
    required String email,
    required String password,
    String role = 'employee',
  }) async {
    final response = await post(
      '${ApiEndpoint.baseUrl}/auth/register',
      {
        'fullName': fullName,
        'email': email,
        'role': role,
        'password': password,
      },
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}
