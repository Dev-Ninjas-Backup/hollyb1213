import 'dart:io';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:mime/mime.dart';

class UploadNidService extends GetConnect {
  // Ensure onInit is called when instantiated directly
  UploadNidService() {
    onInit();
  }

  @override
  void onInit() {
    httpClient.baseUrl = ApiEndpoint.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);
    super.onInit();
  }

  Future<Response> uploadNid(File frontImage, File backImage) async {
    final token = await SharedPreferenceHelper().getAccessToken();

    final frontFileName = frontImage.path.split('/').last;
    final backFileName = backImage.path.split('/').last;

    final frontMimeType = lookupMimeType(frontImage.path);
    final backMimeType = lookupMimeType(backImage.path);

    final formData = FormData({
      'front': MultipartFile(frontImage,
          filename: frontFileName, contentType: frontMimeType ?? 'image/jpeg'),
      'back': MultipartFile(backImage,
          filename: backFileName, contentType: backMimeType ?? 'image/jpeg'),
    });

    return await post(
      ApiEndpoint.uploadNid,
      formData,
      headers: {'Authorization': 'Bearer ${token ?? ''}'},
    );
  }
}
