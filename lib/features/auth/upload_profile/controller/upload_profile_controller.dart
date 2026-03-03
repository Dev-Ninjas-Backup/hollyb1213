// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hollyb1213/features/auth/upload_profile/service/upload_profile_service.dart';
import 'package:hollyb1213/routes/app_route.dart';

class UploadProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final UploadProfileService _service = UploadProfileService();

  var image = Rx<File?>(null);
  var isLoading = false.obs;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  Future<void> uploadProfilePhoto() async {
    if (image.value == null) return;

    isLoading.value = true;
    EasyLoading.show(status: 'Uploading...');
    try {
      final response = await _service.uploadProfilePhoto(image.value!);

      print('Upload Status: ${response.statusCode}');
      print('Upload Body: ${response.body}');
      EasyLoading.dismiss();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Profile photo uploaded successfully');
        Get.offNamed(AppRoute.getuploadNidScreen());
      } else {
        final message =
            response.body?['message'] ?? 'Upload failed. Please try again.';
        Get.snackbar(
          'Upload Failed',
          message,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('Upload error: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
