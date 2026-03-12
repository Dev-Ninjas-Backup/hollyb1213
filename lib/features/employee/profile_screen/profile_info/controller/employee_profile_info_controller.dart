import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/routes/app_route.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile_info/service/employee_profile_info_service.dart';

class EmployeeProfileInfoController extends GetxController {
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final skillController = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();
  final experienceYearsController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final EmployeeProfileInfoService _service = EmployeeProfileInfoService();

  Rx<File?> selectedImage = Rx<File?>(null);
  var isLoading = false.obs;
  var profilePhotoUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final response = await _service.getProfile();

      if (response.statusCode == 200 && response.body['success'] == true) {
        final data = response.body['data'];
        final profile = data['profile'] ?? {};
        final employeeProfile = data['employee_profile'] ?? {};

        // Populate controllers with fetched data
        fullNameController.text = data['full_name'] ?? '';
        phoneNumberController.text = data['phone'] ?? '';
        addressController.text =
            employeeProfile['address'] ?? profile['address'] ?? '';
        dobController.text = _formatDate(
            employeeProfile['date_of_birth'] ?? profile['dateOfBirth']);

        // Handle skills - from employee_skills array or profile.skills
        final employeeSkillsData = employeeProfile['employee_skills'];
        if (employeeSkillsData != null && employeeSkillsData is List) {
          final skills = (employeeSkillsData)
              .map((skillItem) => skillItem['skill']?['name'] ?? '')
              .where((skill) => skill.isNotEmpty)
              .toList();
          if (skills.isNotEmpty) {
            skillController.text = skills.join(', ');
          } else if (profile['skills'] != null) {
            if (profile['skills'] is String) {
              skillController.text = profile['skills'];
            } else if (profile['skills'] is List) {
              skillController.text = (profile['skills']).join(', ');
            }
          }
        } else if (profile['skills'] != null) {
          if (profile['skills'] is String) {
            skillController.text = profile['skills'];
          } else if (profile['skills'] is List) {
            skillController.text = (profile['skills']).join(', ');
          }
        }

        experienceYearsController.text = (employeeProfile['experience_years'] ??
                profile['experienceYears'] ??
                '')
            .toString();
        profilePhotoUrl.value = employeeProfile['profile_photo_url'] ??
            profile['profilePhotoUrl'] ??
            '';
      } else {
        EasyLoading.showError('Failed to fetch profile');
      }
    } catch (e) {
      EasyLoading.showError('Error fetching profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(date);
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return date;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  void clearImage() {
    selectedImage.value = null;
  }

  Future<void> updateProfile() async {
    try {
      EasyLoading.show(status: 'Updating profile...');

      // Parse experience years
      int experienceYears = 0;
      if (experienceYearsController.text.isNotEmpty) {
        experienceYears = int.tryParse(experienceYearsController.text) ?? 0;
      }

      // Parse skills
      List<String> skills = skillController.text
          .split(',')
          .map((skill) => skill.trim())
          .where((skill) => skill.isNotEmpty)
          .toList();

      final response = await _service.updateProfile(
        fullName: fullNameController.text,
        phoneNumber: phoneNumberController.text,
        address: addressController.text,
        dateOfBirth: dobController.text,
        skills: skills,
        experienceYears: experienceYears,
        profilePhoto: selectedImage.value,
      );

      if (response.statusCode == 200 && response.body['success'] == true) {
        Get.back();
        EasyLoading.showSuccess('Profile updated successfully');
        // Clear selected image after successful upload
        clearImage();
        // Refresh profile data
        await fetchProfile();
      } else {
        EasyLoading.showError(
            response.body['message'] ?? 'Failed to update profile');
      }
    } catch (e) {
      EasyLoading.showError('Error updating profile: $e');
    }
  }

  Future<void> deleteProfile() async {
    try {
      EasyLoading.show(status: 'Deleting account...');

      final response = await _service.deleteUserProfile();
      EasyLoading.dismiss();

      if (response.statusCode == 200 && response.body['success'] == true) {
        // Clear all stored data including token
        await SharedPreferenceHelper().clearAll();
        EasyLoading.showSuccess('Account deleted successfully');

        // Navigate after showing success message
        Future.delayed(Duration(seconds: 1), () {
          Get.offAll(() => AppRoute.loginScreen);
        });
      } else {
        EasyLoading.showError(
            response.body['message'] ?? 'Failed to delete profile');
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Error deleting profile: $e');
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    skillController.dispose();
    addressController.dispose();
    dobController.dispose();
    experienceYearsController.dispose();
    super.onClose();
  }
}
