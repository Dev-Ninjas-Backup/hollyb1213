// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hollyb1213/features/auth/upload_nid/service/upload_nid_service.dart';
import 'package:hollyb1213/routes/app_route.dart';

class UploadNidController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final UploadNidService _service = UploadNidService();

  var frontImage = Rx<File?>(null);
  var backImage = Rx<File?>(null);
  var isLoading = false.obs;

  bool get isFrontImageSelected => frontImage.value != null;
  bool get isBackImageSelected => backImage.value != null;
  bool get isBothSelected => isFrontImageSelected && isBackImageSelected;

  Future<void> pickFrontImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      frontImage.value = File(pickedFile.path);
    }
  }

  Future<void> pickBackImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      backImage.value = File(pickedFile.path);
    }
  }

  Future<void> uploadNid() async {
    if (!isBothSelected) return;

    // Store the images locally to prevent null issues from async operations
    final front = frontImage.value;
    final back = backImage.value;

    if (front == null || back == null) {
      Get.snackbar(
        'Error',
        'Please select both images before uploading.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;
    EasyLoading.show(status: 'Uploading NID...');
    try {
      final response = await _service.uploadNid(
        frontImage: front,
        backImage: back,
      );

      print('NID Upload Status: ${response.statusCode}');
      print('NID Upload Body: ${response.body}');
      EasyLoading.dismiss();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'NID uploaded successfully');
        Get.offNamed(AppRoute.getuploadPassportScreen());
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
      print('NID upload error: $e');
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
