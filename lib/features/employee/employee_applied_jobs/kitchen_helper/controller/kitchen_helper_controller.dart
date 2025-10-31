import 'package:get/get.dart';

class KitchenHelperController extends GetxController {
  var isCheckedIn = false.obs;
  var isCheckedOut = false.obs;
  var isCompleted = false.obs;

  void checkIn() {
    isCheckedIn.value = true;
  }

  void checkOut() {
    if (isCheckedIn.value) {
      isCheckedOut.value = true;
    }
  }

  void markCompleted() {
    if (isCheckedOut.value) {
      isCompleted.value = true;
    }
  }
}
