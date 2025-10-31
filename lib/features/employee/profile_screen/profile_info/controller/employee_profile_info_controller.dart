import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeProfileInfoController extends GetxController{
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final skillController = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }
  

  void clearImage() {
    selectedImage.value = null;
  }


}