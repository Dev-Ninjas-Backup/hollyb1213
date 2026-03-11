import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';

class ProfileService extends GetConnect {
  Future<Response> getProfile() async {
    final String? token = await SharedPreferenceHelper().getAccessToken();
    final response = await get(
      ApiEndpoint.getProfile,
      headers: {
        'Authorization': 'Bearer ${token ?? ''}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    // ignore: avoid_print
    print('Profile API Response: ${response.body}');
    return response;
  }

  Future<Response> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final String? token = await SharedPreferenceHelper().getAccessToken();
    final response = await post(
      '${ApiEndpoint.baseUrl}${ApiEndpoint.changePassword}',
      {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      },
      headers: {
        'Authorization': 'Bearer ${token ?? ''}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    // ignore: avoid_print
    print('Change Password API Response: ${response.body}');
    return response;
  }
}
