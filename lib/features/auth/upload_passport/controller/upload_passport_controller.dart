// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hollyb1213/features/auth/upload_passport/service/upload_passport_service.dart';
import 'package:hollyb1213/routes/app_route.dart';

class UploadPassportController extends GetxController {
  var frontImage = Rx<File?>(null);
  var backImage = Rx<File?>(null);
  var isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();
  final UploadPassportService _service = UploadPassportService();
import 'package:hollyb1213/core/common/constants/upload_passport_service.dart';
import 'package:hollyb1213/routes/app_route.dart';

class UploadPassportController extends GetxController {
  final UploadPassportService _service = UploadPassportService();
  final ImagePicker _picker = ImagePicker();
  var image = Rx<File?>(null);

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  Future<void> uploadPassport() async {
    if (image.value == null) return;

    EasyLoading.show(status: 'Uploading Passport...');
    try {
      final response = await _service.uploadPassport(image.value!);
      print("Passport Upload API Response: ${response.body}");
      EasyLoading.dismiss();

  bool get isFrontImageSelected => frontImage.value != null;
  bool get isBackImageSelected => backImage.value != null;
  bool get isBothSelected => isFrontImageSelected && isBackImageSelected;

  Future<void> uploadPassport() async {
    if (!isBothSelected) return;

    isLoading.value = true;
    try {
      final response = await _service.uploadPassport(
        frontImage: frontImage.value!,
        backImage: backImage.value!,
      );

      print('Passport Upload Status: ${response.statusCode}');
      print('Passport Upload Body: ${response.body}');

      if (response.statusCode == 201 &&
          response.body != null &&
          response.body['success'] == true) {
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
      print('Passport upload error: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Passport uploaded successfully");
        // Navigate to the main dashboard, removing all previous routes
        Get.offAllNamed('/employee/dashboard');
      } else {
        Get.snackbar("Error", response.body['message'] ?? "Upload failed");
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}
