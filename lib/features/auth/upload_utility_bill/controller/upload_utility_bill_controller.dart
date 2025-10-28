import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadUtilityBillController extends GetxController {
  var backImage = Rx<File?>(null);
  var address = ''.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickBackImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      backImage.value = File(pickedFile.path);
    }
  }

  void removeBackImage() => backImage.value = null;

  bool get isSubmitEnabled => backImage.value != null && address.isNotEmpty;
}
