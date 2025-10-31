import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';

class CreatePostController extends GetxController {
  final jobTitleController = TextEditingController();
  final jobCategoryController = TextEditingController();
  final jobTypeController = TextEditingController(text: "Hourly");
  final jobDescriptionController = TextEditingController();

  var isUrgent = false.obs;
  final jobTypes = ["Hourly", "Full-time", "Part-time", "Contract"].obs;

  var selectedDates = List.generate(2, (index) => Rxn<DateTime>()).obs;
  var selectedTimes = List.generate(2, (index) => Rxn<TimeOfDay>()).obs;

  void toggleUrgent(bool value) => isUrgent.value = value;

  Future<void> pickDate(BuildContext context, int index) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDates[index].value ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      selectedDates[index].value = picked;
    }
  }

  Future<void> pickTime(BuildContext context, int index) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTimes[index].value ?? TimeOfDay.now(),
    );
    if (picked != null) {
      selectedTimes[index].value = picked;
    }
  }

  void saveChanges() {
    Get.snackbar(
      "Saved",
      "Your changes have been saved successfully!",
      backgroundColor: Appcolor.primaryColor,
      colorText: Colors.white,
    );
  }

  void cancelChanges() => Get.back();
}
