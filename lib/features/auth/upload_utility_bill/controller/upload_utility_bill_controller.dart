// ignore_for_file: avoid_print

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readytowork/features/auth/upload_utility_bill/service/upload_utility_bill_service.dart';
import 'package:readytowork/routes/app_route.dart';


class UploadUtilityBillController extends GetxController {
  var backImage = Rx<File?>(null);
  var address = ''.obs;
  var isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();
  final UploadUtilityBillService _service = UploadUtilityBillService();

  Future<void> pickBackImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      backImage.value = File(pickedFile.path);
    }
  }

  void removeBackImage() => backImage.value = null;

  bool get isSubmitEnabled => backImage.value != null && address.isNotEmpty;

  Future<void> uploadUtilityBill() async {
    if (!isSubmitEnabled) return;

    // Store values locally to prevent null issues from async operations
    final image = backImage.value;
    final addr = address.value;

    if (image == null || addr.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select an image and enter an address before uploading.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await _service.uploadUtilityBill(
        imageFile: image,
        address: addr,
      );

      print('Utility Bill Upload Status: ${response.statusCode}');
      print('Utility Bill Upload Body: ${response.body}');

      if (response.statusCode == 201 &&
          response.body != null &&
          response.body['success'] == true) {
        Get.toNamed(AppRoute.getpaymentMethodScreen());
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
      print('Utility bill upload error: $e');
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
