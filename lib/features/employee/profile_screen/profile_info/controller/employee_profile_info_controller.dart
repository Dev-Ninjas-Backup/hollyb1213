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

        // Populate controllers with fetched data
        fullNameController.text = data['full_name'] ?? '';
        phoneNumberController.text = data['phone'] ?? '';
        addressController.text = profile['address'] ?? '';
        dobController.text = profile['dateOfBirth'] ?? '';

        // Handle skills - if it's a string, split by comma
        final skillsData = profile['skills'];
        if (skillsData != null) {
          if (skillsData is String) {
            skillController.text = skillsData;
          } else if (skillsData is List) {
            skillController.text = (skillsData).join(', ');
          }
        }

        experienceYearsController.text =
            (profile['experienceYears'] ?? '').toString();
        profilePhotoUrl.value = profile['profilePhotoUrl'] ?? '';
      } else {
        EasyLoading.showError('Failed to fetch profile');
      }
    } catch (e) {
      EasyLoading.showError('Error fetching profile: $e');
    } finally {
      isLoading.value = false;
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
