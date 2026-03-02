import 'dart:io';

import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';

class UploadProfileService extends GetConnect {
  Future<Response> uploadProfilePhoto(File imageFile) async {
    final token = await SharedPreferenceHelper().getAccessToken();
    final bytes = await imageFile.readAsBytes();
    final fileName = imageFile.path.split('/').last;
    final ext = fileName.split('.').last.toLowerCase();
    final mimeType = ext == 'png'
        ? 'image/png'
        : ext == 'webp'
            ? 'image/webp'
            : 'image/jpeg';

    final formData = FormData({
      'file': MultipartFile(bytes, filename: fileName, contentType: mimeType),
    });

    return await post(
      ApiEndpoint.employerUploadProfilePhoto,
      formData,
      headers: {
        'Authorization': 'Bearer ${token ?? ''}',
        'accept': '*/*',
      },
    );
  }
}
