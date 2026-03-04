import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/employer/create_post/service/create_post_service.dart';
import 'package:hollyb1213/routes/app_route.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostController extends GetxController {
  // Text controllers
  final jobTitleController = TextEditingController();
  final companyNameController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final amountController = TextEditingController();
  final locationController = TextEditingController();

  // Reactive state
  var isUrgent = false.obs;
  var isLoading = false.obs;
  var selectedCategory = Rxn<String>();

  // Date & Time
  var selectedJobDate = Rxn<DateTime>();
  var startTime = Rxn<TimeOfDay>();
  var endTime = Rxn<TimeOfDay>();

  // Dynamic lists for responsibilities & requirements
  var responsibilities = <TextEditingController>[].obs;
  var requirements = <TextEditingController>[].obs;

  // Image file
  var selectedImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();

  // Service
  final CreatePostService _service = CreatePostService();

  // Job categories from API enum
  final jobCategories = [
    'chef',
    'sous_chef',
    'line_cook',
    'pastry_chef',
    'cleaner',
    'dishwasher',
    'helper',
    'server',
    'waiter',
    'bartender',
    'host',
    'manager',
    'supervisor',
    'cook',
  ];

  // Display-friendly category names
  String categoryDisplayName(String cat) {
    return cat.replaceAll('_', ' ').split(' ').map((w) {
      if (w.isEmpty) return w;
      return w[0].toUpperCase() + w.substring(1);
    }).join(' ');
  }

  @override
  void onInit() {
    super.onInit();
    // Start with one empty field each
    addResponsibility();
    addRequirement();
  }

  // --- Responsibilities ---
  void addResponsibility() {
    responsibilities.add(TextEditingController());
  }

  void removeResponsibility(int index) {
    if (responsibilities.length > 1) {
      responsibilities[index].dispose();
      responsibilities.removeAt(index);
    }
  }

  // --- Requirements ---
  void addRequirement() {
    requirements.add(TextEditingController());
  }

  void removeRequirement(int index) {
    if (requirements.length > 1) {
      requirements[index].dispose();
      requirements.removeAt(index);
    }
  }

  // --- Toggle Urgent ---
  void toggleUrgent(bool value) => isUrgent.value = value;

  // --- Date & Time Pickers ---
  Future<void> pickJobDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedJobDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      selectedJobDate.value = picked;
    }
  }

  Future<void> pickStartTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: startTime.value ?? TimeOfDay.now(),
    );
    if (picked != null) {
      startTime.value = picked;
    }
  }

  Future<void> pickEndTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: endTime.value ?? TimeOfDay.now(),
    );
    if (picked != null) {
      endTime.value = picked;
    }
  }

  // --- Image Picker ---
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  void removeImage() {
    selectedImage.value = null;
  }

  // --- Format helpers ---
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  // --- Validation ---
  bool _validate() {
    if (jobTitleController.text.trim().isEmpty) {
      Get.snackbar('Validation', 'Job title is required',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    if (companyNameController.text.trim().isEmpty) {
      Get.snackbar('Validation', 'Company name is required',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    if (selectedCategory.value == null || selectedCategory.value!.isEmpty) {
      Get.snackbar('Validation', 'Please select a job category',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    if (amountController.text.trim().isEmpty) {
      Get.snackbar('Validation', 'Amount is required',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    if (locationController.text.trim().isEmpty) {
      Get.snackbar('Validation', 'Location is required',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    if (selectedJobDate.value == null) {
      Get.snackbar('Validation', 'Please select a job date',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    if (startTime.value == null) {
      Get.snackbar('Validation', 'Please select a start time',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    if (endTime.value == null) {
      Get.snackbar('Validation', 'Please select an end time',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    return true;
  }

  // --- Submit ---
  Future<void> saveChanges() async {
    if (!_validate()) return;
    isLoading.value = true;
    try {
      final responsibilitiesList = responsibilities
          .map((c) => c.text.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final requirementsList = requirements
          .map((c) => c.text.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final response = await _service.createJobPost(
        title: jobTitleController.text.trim(),
        companyName: companyNameController.text.trim(),
        description: jobDescriptionController.text.trim(),
        jobCategory: selectedCategory.value ?? '',
        jobResponsibilities: responsibilitiesList,
        requirements: requirementsList,
        isUrgent: isUrgent.value,
        jobDate: selectedJobDate.value != null
            ? _formatDate(selectedJobDate.value!)
            : '',
        startTime: startTime.value != null ? _formatTime(startTime.value!) : '',
        endTime: endTime.value != null ? _formatTime(endTime.value!) : '',
        amount: amountController.text.trim(),
        location: locationController.text.trim(),
        imageFile: selectedImage.value,
      );

      print('Create Post Response: ${response.statusCode}');
      print('Create Post Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body['success'] == true) {
          Get.back();
          Get.snackbar(
            'Success',
            'Job post created successfully!',
            backgroundColor: Appcolor.primaryColor,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        } else {
          final message = response.body['message'] ?? 'Failed to create post.';
          Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
        }
      } else if (response.statusCode == 403) {
        // Handle subscription required error
        final message = response.body?['message'] ??
            'Subscription required to create job posts.';
        Get.snackbar(
          'Subscription Required',
          message,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );

        // Redirect to payment screen after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          final role = SharedPreferenceHelper().getSelectedRole();
          print('Redirecting to payment screen for role: $role');
          Get.offNamed(AppRoute.paymentMethodScreen);
        });
      } else {
        final message = response.body?['message'] ?? 'Failed to create post.';
        Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print('Create post error: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void cancelChanges() => Get.back();

  @override
  void onClose() {
    jobTitleController.dispose();
    companyNameController.dispose();
    jobDescriptionController.dispose();
    amountController.dispose();
    locationController.dispose();
    for (final c in responsibilities) {
      c.dispose();
    }
    for (final c in requirements) {
      c.dispose();
    }
    super.onClose();
  }
}
