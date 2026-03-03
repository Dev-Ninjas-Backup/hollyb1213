// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hollyb1213/features/auth/upload_passport/service/upload_passport_service.dart';
import 'package:hollyb1213/routes/app_route.dart';

class UploadPassportController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final UploadPassportService _service = UploadPassportService();

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

  Future<void> uploadPassport() async {
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
    EasyLoading.show(status: 'Uploading Passport...');
    try {
      final response = await _service.uploadPassport(
        frontImage: front,
        backImage: back,
      );

      print('Passport Upload Status: ${response.statusCode}');
      print('Passport Upload Body: ${response.body}');
      EasyLoading.dismiss();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Passport uploaded successfully');
        Get.toNamed(AppRoute.getuploadUtilityBillScreen());
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
      print('Passport upload error: $e');
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
