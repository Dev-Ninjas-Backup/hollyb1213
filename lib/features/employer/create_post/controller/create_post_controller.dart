import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CreatePostController extends GetxController {
  // Text Controllers
  final jobTitleController = TextEditingController();
  final jobCategoryController = TextEditingController();
  final jobTypeController = TextEditingController(text: "Hourly");
  final jobDescriptionController = TextEditingController();

  // Reactive Variables
  var isUrgent = false.obs;

  // Dropdown options
  final jobTypes = ["Hourly", "Full-time", "Part-time", "Contract"].obs;

  // Date fields (for 4 shadow boxes)
  var selectedDates = List.generate(4, (index) => Rxn<DateTime>());

  // Function: toggle urgent
  void toggleUrgent(bool value) {
    isUrgent.value = value;
  }

  // Function: select date
  Future<void> pickDate(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      selectedDates[index].value = picked;
    }
  }

  // Save and Cancel
  void saveChanges() {
    Get.snackbar(
      "Saved",
      "Your changes have been saved successfully!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void cancelChanges() {
    Get.back();
  }
}
