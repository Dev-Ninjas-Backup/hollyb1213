// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/upload_nid_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hollyb1213/routes/app_route.dart';

class UploadNidController extends GetxController {
  final UploadNidService _service = UploadNidService();
  final ImagePicker _picker = ImagePicker();

  var frontImage = Rx<File?>(null);
  var backImage = Rx<File?>(null);

  bool get isBothSelected =>
      frontImage.value != null && backImage.value != null;

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

    EasyLoading.show(status: 'Uploading NID...');
    try {
      final response =
          await _service.uploadNid(frontImage.value!, backImage.value!);
      print("NID Upload API Response: ${response.body}");
      EasyLoading.dismiss();

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar("Success", "NID uploaded successfully");
        // Navigate to next screen and remove current from stack
        Get.offNamed(AppRoute.getuploadPassportScreen());
      } else {
        Get.snackbar("Error", response.body['message'] ?? "Upload failed");
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}
