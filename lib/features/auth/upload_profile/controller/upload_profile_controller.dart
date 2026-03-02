import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hollyb1213/features/auth/upload_profile/service/upload_profile_service.dart';
import 'package:hollyb1213/routes/app_route.dart';

class UploadProfileController extends GetxController {
  var image = Rx<File?>(null);
  var isLoading = false.obs;
  final ImagePicker _picker = ImagePicker();
  final UploadProfileService _service = UploadProfileService();

  // Pick image from camera or gallery
  Future<void> pickImage() async {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take Photo'),
              onTap: () async {
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.camera,
                );
                if (pickedFile != null) {
                  image.value = File(pickedFile.path);
                }
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () async {
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  image.value = File(pickedFile.path);
                }
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadProfilePhoto() async {
    if (image.value == null) return;

    isLoading.value = true;
    try {
      final response = await _service.uploadProfilePhoto(image.value!);

      print('Upload Status: ${response.statusCode}');
      print('Upload Body: ${response.body}');

      if (response.statusCode == 201 &&
          response.body != null &&
          response.body['success'] == true) {
        Get.toNamed(AppRoute.getuploadNidScreen());
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
