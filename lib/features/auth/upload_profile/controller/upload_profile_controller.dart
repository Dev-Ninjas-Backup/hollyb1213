import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadProfileController extends GetxController {
  var image = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }
}
