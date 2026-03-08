import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';

class LoginService extends GetConnect {
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    return await post(
      '${ApiEndpoint.baseUrl}${ApiEndpoint.login}',
      {
        'email': email,
        'password': password,
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  Future<Response> loginWithGoogle({
    required String idToken,
    required String role,
  }) async {
    return await post(
      '${ApiEndpoint.baseUrl}${ApiEndpoint.googleLogin}',
      {
        'idToken': idToken,
        'role': role,
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  Future<Response> loginWithFacebook({
    required String idToken,
    required String role,
  }) async {
    return await post(
      '${ApiEndpoint.baseUrl}${ApiEndpoint.facebookLogin}',
      {
        'idToken': idToken,
        'role': role,
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }
}
