// ignore_for_file: avoid_print

import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:readytowork/features/employer/create_post/service/create_post_service.dart';
import 'package:readytowork/features/employer/home/controller/employer_home_controller.dart';
import 'package:readytowork/features/employer/job_details/controller/job_details_controller.dart';
import 'package:readytowork/features/employer/jobs/controller/employer_jobs_controller.dart';
import 'package:readytowork/routes/app_route.dart';

class CreatePostController extends GetxController {
  // Text controllers
  final jobTitleController = TextEditingController();
  final companyNameController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final amountController = TextEditingController();
  final locationController = TextEditingController();

  // Edit mode
  var jobId = Rxn<String>();
  var isEditMode = false.obs;

  // Reactive state
  var isUrgent = false.obs;
  var isLoading = false.obs;
  var isFetchingJobDetails = false.obs;
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
  var existingImageUrl =
      Rxn<String>(); // For displaying existing image during edit
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

    // Load job details if in edit mode
    if (Get.arguments != null && Get.arguments is String) {
      final jobIdArg = Get.arguments as String;
      loadJobDetails(jobIdArg);
    }
  }

  // --- Load Job Details for Edit ---
  Future<void> loadJobDetails(String id) async {
    try {
      jobId.value = id;
      isEditMode.value = true;
      isFetchingJobDetails.value = true;

      final response = await _service.getJobDetails(id);

      if (response.statusCode == 200 && response.body['success'] == true) {
        final jobData = response.body['data'] as Map<String, dynamic>;

        // Populate form fields
        jobTitleController.text = jobData['title'] ?? '';
        companyNameController.text = jobData['company_name'] ?? '';
        jobDescriptionController.text = jobData['description'] ?? '';
        amountController.text = jobData['amount']?.toString() ?? '';
        locationController.text = jobData['location'] ?? '';
        isUrgent.value = jobData['is_urgent'] ?? false;
        selectedCategory.value = jobData['job_category'] ?? '';

        // Parse job date
        if (jobData['job_date'] != null) {
          try {
            selectedJobDate.value =
                DateTime.parse(jobData['job_date'].toString());
          } catch (e) {
            print('Error parsing job date: $e');
          }
        }

        // Parse start time
        if (jobData['start_time'] != null) {
          startTime.value = _parseTimeOfDay(jobData['start_time'].toString());
        }

        // Parse end time
        if (jobData['end_time'] != null) {
          endTime.value = _parseTimeOfDay(jobData['end_time'].toString());
        }

        // Load responsibilities
        responsibilities.clear();
        final respList = jobData['job_responsibilities'] as List<dynamic>?;
        if (respList != null && respList.isNotEmpty) {
          for (final resp in respList) {
            final controller = TextEditingController(text: resp.toString());
            responsibilities.add(controller);
          }
        } else {
          addResponsibility();
        }

        // Load requirements
        requirements.clear();
        final reqList = jobData['requirements'] as List<dynamic>?;
        if (reqList != null && reqList.isNotEmpty) {
          for (final req in reqList) {
            final controller = TextEditingController(text: req.toString());
            requirements.add(controller);
          }
        } else {
          addRequirement();
        }

        // Load existing image URL
        if (jobData['file'] is Map &&
            (jobData['file'] as Map).containsKey('url')) {
          existingImageUrl.value = jobData['file']['url']?.toString();
        }

        print('Job details loaded successfully');
      } else {
        Get.snackbar('Error', 'Failed to load job details',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print('Error loading job details: $e');
      Get.snackbar('Error', 'Failed to load job details',
          snackPosition: SnackPosition.TOP);
    } finally {
      isFetchingJobDetails.value = false;
    }
  }

  // --- Parse time of day from string (e.g., "04:11 AM") ---
  TimeOfDay _parseTimeOfDay(String timeString) {
    try {
      final parts = timeString.split(' ');
      if (parts.length != 2) throw Exception('Invalid time format');

      final timeParts = parts[0].split(':');
      var hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      final period = parts[1].toUpperCase();

      // Convert 12-hour to 24-hour format for TimeOfDay
      if (period == 'PM' && hour != 12) {
        hour += 12;
      } else if (period == 'AM' && hour == 12) {
        hour = 0;
      }

      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      print('Error parsing time: $e');
      return TimeOfDay.now();
    }
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

      final Response response;

      if (isEditMode.value && jobId.value != null) {
        // Update existing job
        response = await _service.updateJobPost(
          jobId: jobId.value!,
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
          startTime:
              startTime.value != null ? _formatTime(startTime.value!) : '',
          endTime: endTime.value != null ? _formatTime(endTime.value!) : '',
          amount: amountController.text.trim(),
          location: locationController.text.trim(),
          imageFile: selectedImage.value,
        );

        print('Update Post Response: ${response.statusCode}');
        print('Update Post Body: ${response.body}');

        if (response.statusCode == 200) {
          if (response.body['success'] == true) {
            // Refresh JobDetailsScreen by calling the controller's method
            final updatedJobId = jobId.value;
            Get.back();

            // Delay slightly to ensure navigation completes
            Future.delayed(const Duration(milliseconds: 500), () {
              try {
                // Find and refresh the JobDetailsController
                if (Get.isRegistered<JobDetailsController>()) {
                  final controller = Get.find<JobDetailsController>();
                  if (updatedJobId != null) {
                    controller.fetchJobDetails(updatedJobId);
                  }
                }

                // Refresh EmployerHomeController
                if (Get.isRegistered<EmployerHomeController>()) {
                  final homeController = Get.find<EmployerHomeController>();
                  homeController.onInit();
                }

                // Refresh EmployerJobsController
                if (Get.isRegistered<EmployerJobsController>()) {
                  final jobsController = Get.find<EmployerJobsController>();
                  jobsController.fetchJobs(isRefresh: true);
                }
              } catch (e) {
                print('Could not refresh controllers: $e');
              }
            });

            Get.snackbar(
              'Success',
              'Job post updated successfully!',
              backgroundColor: Appcolor.primaryColor,
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          } else {
            final message =
                response.body['message'] ?? 'Failed to update post.';
            Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
          }
        } else {
          final message = response.body?['message'] ?? 'Failed to update post.';
          Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
        }
      } else {
        // Create new job
        response = await _service.createJobPost(
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
          startTime:
              startTime.value != null ? _formatTime(startTime.value!) : '',
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
            final message =
                response.body['message'] ?? 'Failed to create post.';
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
      }
    } catch (e) {
      print('Save post error: $e');
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
