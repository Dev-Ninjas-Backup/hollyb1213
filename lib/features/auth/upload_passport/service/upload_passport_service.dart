import 'dart:io';

import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';

class UploadPassportService extends GetConnect {
  static String _mimeType(String path) {
    final ext = path.split('.').last.toLowerCase();
    if (ext == 'png') return 'image/png';
    if (ext == 'webp') return 'image/webp';
    return 'image/jpeg';
  }

  Future<Response> uploadPassport({
    required File frontImage,
    required File backImage,
  }) async {
    final token = await SharedPreferenceHelper().getAccessToken();

    if (token == null || token.isEmpty) {
      throw Exception('Authentication token not found. Please log in again.');
    }

    final frontBytes = await frontImage.readAsBytes();
    final frontName = frontImage.path.split('/').last;

    final backBytes = await backImage.readAsBytes();
    final backName = backImage.path.split('/').last;

    final formData = FormData({
      'front': MultipartFile(
        frontBytes,
        filename: frontName,
        contentType: _mimeType(frontName),
      ),
      'back': MultipartFile(
        backBytes,
        filename: backName,
        contentType: _mimeType(backName),
      ),
    });

    return await post(
      ApiEndpoint.employerUploadPassportPhoto,
      formData,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': '*/*',
      },
    );
  }
}
