// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
