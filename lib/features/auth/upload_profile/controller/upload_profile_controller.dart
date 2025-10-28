import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadProfileController extends GetxController {
  var image = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

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
}
