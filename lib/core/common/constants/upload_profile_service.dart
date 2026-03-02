import 'dart:io';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:mime/mime.dart';

class UploadProfileService extends GetConnect {
  // Ensure onInit is called when instantiated directly
  UploadProfileService() {
    onInit();
  }

  @override
  void onInit() {
    httpClient.baseUrl = ApiEndpoint.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);
    super.onInit();
  }

  Future<Response> uploadProfilePhoto(File image) async {
    final token = await SharedPreferenceHelper().getAccessToken();

    final fileName = image.path.split('/').last;
    final mimeType = lookupMimeType(image.path);

    final formData = FormData({
      'photo': MultipartFile(image,
          filename: fileName, contentType: mimeType ?? 'image/jpeg'),
    });

    return await post(
      ApiEndpoint.profilePhoto,
      formData,
      headers: {'Authorization': 'Bearer ${token ?? ''}'},
    );
  }
}
