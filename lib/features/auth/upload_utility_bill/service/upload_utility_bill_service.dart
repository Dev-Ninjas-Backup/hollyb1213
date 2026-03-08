import 'dart:io';

import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';

class UploadUtilityBillService extends GetConnect {
  static String _mimeType(String path) {
    final ext = path.split('.').last.toLowerCase();
    if (ext == 'png') return 'image/png';
    if (ext == 'webp') return 'image/webp';
    return 'image/jpeg';
  }

  Future<Response> uploadUtilityBill({
    required File imageFile,
    required String address,
  }) async {
    final token = await SharedPreferenceHelper().getAccessToken();

    if (token == null || token.isEmpty) {
      throw Exception('Authentication token not found. Please log in again.');
    }

    final bytes = await imageFile.readAsBytes();
    final fileName = imageFile.path.split('/').last;

    final formData = FormData({
      'address': address,
      'file': MultipartFile(
        bytes,
        filename: fileName,
        contentType: _mimeType(fileName),
      ),
    });

    return await post(
      '${ApiEndpoint.baseUrl}${ApiEndpoint.uploadUtilityBill}',
      formData,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': '*/*',
      },
    );
  }
}
