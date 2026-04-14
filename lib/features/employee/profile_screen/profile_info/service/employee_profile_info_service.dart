// ignore_for_file: avoid_print

import 'dart:io';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/api_endpoint.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';

class EmployeeProfileInfoService extends GetConnect {
  static String _mimeType(String path) {
    final ext = path.split('.').last.toLowerCase();
    if (ext == 'png') return 'image/png';
    if (ext == 'webp') return 'image/webp';
    return 'image/jpeg';
  }

  Future<Response> getProfile() async {
    final token = await SharedPreferenceHelper().getAccessToken();
    final response = await get(
      ApiEndpoint.getProfile,
      headers: {
        'Authorization': 'Bearer ${token ?? ''}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print('Profile API Response: ${response.body}');
    return response;
  }

  Future<Response> updateProfile({
    required String fullName,
    required String phoneNumber,
    required String address,
    required String dateOfBirth,
    required List<String> skills,
    required int experienceYears,
    File? profilePhoto,
  }) async {
    final token = await SharedPreferenceHelper().getAccessToken();

    if (token == null || token.isEmpty) {
      throw Exception('Authentication token not found. Please log in again.');
    }

    final formData = FormData({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'address': address,
      'dateOfBirth': dateOfBirth,
      'experienceYears': experienceYears.toString(),
    });

    // Add skills array
    for (int i = 0; i < skills.length; i++) {
      formData.fields.add(MapEntry('skills', skills[i]));
    }

    // Add profile photo if provided
    if (profilePhoto != null) {
      final bytes = await profilePhoto.readAsBytes();
      final fileName = profilePhoto.path.split('/').last;
      formData.files.add(
        MapEntry(
          'profilePhoto',
          MultipartFile(
            bytes,
            filename: fileName,
            contentType: _mimeType(fileName),
          ),
        ),
      );
    }

    final response = await patch(
      ApiEndpoint.updateEmployeeProfile,
      formData,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': '*/*',
      },
    );

    print('Update Profile Response Status: ${response.statusCode}');
    print('Update Profile Response Body: ${response.body}');

    return response;
  }

  Future<Response> deleteUserProfile() async {
    final token = await SharedPreferenceHelper().getAccessToken();
    final response = await delete(
      ApiEndpoint.deleteUserProfile,
      headers: {
        'Authorization': 'Bearer ${token ?? ''}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print('Profile API Response: ${response.body}');
    return response;
  }
}
