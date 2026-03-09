// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/employer/profile_screen/profile_info/model/detailed_profile_model.dart';
import 'dart:convert';

class EmployerProfileInfoController extends GetxController {
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final companyNameController = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);
  Rx<DetailedProfileData?> profileData = Rx<DetailedProfileData?>(null);
  RxBool isLoading = false.obs;
  RxBool isUpdating = false.obs;

  EmployerProfileInfoController() {
    print('[EmployerProfileInfoController] Constructor called');
  }

  @override
  void onInit() {
    print('[EmployerProfileInfoController] onInit() called');
    super.onInit();
    fetchProfileDetails();
  }

  Future<void> fetchProfileDetails() async {
    print('[EmployerProfileInfoController] fetchProfileDetails() started');
    try {
      isLoading.value = true;
      final accessToken = await SharedPreferenceHelper().getAccessToken();

      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.employerProfile),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print('Profile Details Response Status: ${response.statusCode}');
      print('Profile Details Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final profileResponse = DetailedProfileResponse.fromJson(jsonResponse);

        if (profileResponse.success) {
          profileData.value = profileResponse.data;

          // Populate text controllers with fetched data
          fullNameController.text = profileResponse.data.fullName;
          companyNameController.text =
              profileResponse.data.profile?.companyName ?? '';
          addressController.text = profileResponse.data.profile?.address ?? '';
          dobController.text =
              _formatDate(profileResponse.data.profile?.dateOfBirth);

          print('Profile data loaded successfully');
        } else {
          Get.snackbar('Error', profileResponse.message);
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch profile details');
      }
    } catch (e) {
      print('Exception in fetchProfileDetails: $e');
      Get.snackbar('Error', 'Error fetching profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfileDetails() async {
    print('[EmployerProfileInfoController] updateProfileDetails() started');
    try {
      isUpdating.value = true;
      final accessToken = await SharedPreferenceHelper().getAccessToken();

      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      // Create multipart request
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.updateEmployerProfile),
      );

      // Add authorization header
      request.headers['Authorization'] = 'Bearer $accessToken';

      // Add text fields
      request.fields['fullName'] = fullNameController.text;
      request.fields['companyName'] = companyNameController.text;
      request.fields['address'] = addressController.text;

      if (dobController.text.isNotEmpty) {
        request.fields['dateOfBirth'] = dobController.text;
      }

      // Add image if selected
      if (selectedImage.value != null) {
        final file = selectedImage.value!;
        final extension = file.path.split('.').last.toLowerCase();
        final mimeType = _getMimeType(extension);

        request.files.add(
          await http.MultipartFile.fromPath(
            'profilePhoto',
            file.path,
            contentType: mimeType.isEmpty ? null : mimeType as dynamic,
          ),
        );
        print('Image added to request with MIME type: $mimeType');
      }

      print('Sending update request...');
      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print('Update Response Status: ${response.statusCode}');
      print('Update Response Body: $responseBody');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseBody);

        if (jsonResponse['success'] == true) {
          Get.snackbar('Success', 'Profile updated successfully');
          // Refresh profile data
          await fetchProfileDetails();
          selectedImage.value = null;
        } else {
          Get.snackbar('Error', jsonResponse['message'] ?? 'Update failed');
        }
      } else {
        Get.snackbar('Error', 'Failed to update profile');
      }
    } catch (e) {
      print('Exception in updateProfileDetails: $e');
      Get.snackbar('Error', 'Error updating profile: $e');
    } finally {
      isUpdating.value = false;
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

  String _getMimeType(String extension) {
    const mimeTypes = {
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
      'gif': 'image/gif',
      'webp': 'image/webp',
      'bmp': 'image/bmp',
    };
    return mimeTypes[extension] ?? 'image/jpeg';
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage.value = File(image.path);
      print('Image selected: ${selectedImage.value?.path}');
    }
  }

  void clearImage() {
    selectedImage.value = null;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    companyNameController.dispose();
    addressController.dispose();
    dobController.dispose();

    super.onClose();
  }
}
