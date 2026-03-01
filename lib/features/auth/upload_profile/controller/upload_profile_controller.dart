import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/features/auth/upload_profile/screen/upload_profile_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hollyb1213/routes/app_route.dart';

class UploadProfileController extends GetxController {
  final UploadProfileService _service = Get.put(UploadProfileService());
  var image = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  Future<void> uploadProfilePhoto() async {
    if (image.value == null) return;

    try {
      EasyLoading.show(status: 'Uploading...');

      final response = await _service.uploadProfilePhoto(image.value!);

      if (response.statusCode == 200 && response.body['success'] == true) {
        EasyLoading.showSuccess(
            response.body['message'] ?? 'Uploaded successfully');
        Get.toNamed(AppRoute.getuploadNidScreen());
      } else {
        EasyLoading.showError(response.body['message'] ?? 'Upload failed');
      }
    } catch (e) {
      EasyLoading.showError('Something went wrong');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
