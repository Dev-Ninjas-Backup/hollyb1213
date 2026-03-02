// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hollyb1213/core/common/constants/upload_profile_service.dart';
import 'package:hollyb1213/routes/app_route.dart';

class UploadProfileController extends GetxController {
  final UploadProfileService _service = UploadProfileService();
  final ImagePicker _picker = ImagePicker();
  var image = Rx<File?>(null);

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  Future<void> uploadProfilePhoto() async {
    if (image.value == null) return;

    EasyLoading.show(status: 'Uploading...');
    try {
      final response = await _service.uploadProfilePhoto(image.value!);
      print("Upload API Response: ${response.body}");
      EasyLoading.dismiss();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Profile photo uploaded successfully");
        Get.offNamed(AppRoute.uploadNidScreen);
      } else {
        Get.snackbar("Error", response.body['message'] ?? "Upload failed");
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}
