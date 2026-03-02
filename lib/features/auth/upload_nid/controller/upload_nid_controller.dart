import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hollyb1213/features/auth/upload_nid/service/upload_nid_service.dart';
import 'package:hollyb1213/routes/app_route.dart';

class UploadNidController extends GetxController {
  var frontImage = Rx<File?>(null);
  var backImage = Rx<File?>(null);
  var isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();
  final UploadNidService _service = UploadNidService();

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

  void removeFrontImage() => frontImage.value = null;
  void removeBackImage() => backImage.value = null;

  bool get isFrontImageSelected => frontImage.value != null;
  bool get isBackImageSelected => backImage.value != null;
  bool get isBothSelected => isFrontImageSelected && isBackImageSelected;

  Future<void> uploadNid() async {
    if (!isBothSelected) return;

    isLoading.value = true;
    try {
      final response = await _service.uploadNid(
        frontImage: frontImage.value!,
        backImage: backImage.value!,
      );

      print('NID Upload Status: ${response.statusCode}');
      print('NID Upload Body: ${response.body}');

      if (response.statusCode == 201 &&
          response.body != null &&
          response.body['success'] == true) {
        Get.toNamed(AppRoute.getuploadPassportScreen());
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
      print('NID upload error: \$e');
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
