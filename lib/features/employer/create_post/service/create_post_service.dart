import 'dart:io';

import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';

class CreatePostService extends GetConnect {
  Future<Response> createJobPost({
    required String title,
    required String companyName,
    required String description,
    required String jobCategory,
    required List<String> jobResponsibilities,
    required List<String> requirements,
    required bool isUrgent,
    required String jobDate,
    required String startTime,
    required String endTime,
    required String amount,
    required String location,
    File? imageFile,
  }) async {
    final token = await SharedPreferenceHelper().getAccessToken();

    final formFields = <String, dynamic>{
      'title': title,
      'company_name': companyName,
      'is_urgent': isUrgent ? 'true' : 'false',
    };

    if (description.isNotEmpty) formFields['description'] = description;
    if (jobCategory.isNotEmpty) formFields['job_category'] = jobCategory;
    if (jobDate.isNotEmpty) formFields['job_date'] = jobDate;
    if (startTime.isNotEmpty) formFields['start_time'] = startTime;
    if (endTime.isNotEmpty) formFields['end_time'] = endTime;
    if (amount.isNotEmpty) formFields['amount'] = amount;
    if (location.isNotEmpty) formFields['location'] = location;

    // Add array fields
    if (jobResponsibilities.isNotEmpty) {
      formFields['job_responsibilities'] = jobResponsibilities.join(',');
    }
    if (requirements.isNotEmpty) {
      formFields['requirements'] = requirements.join(',');
    }

    // Add image if present
    if (imageFile != null) {
      final fileName = imageFile.path.split('/').last;
      formFields['file'] = MultipartFile(
        imageFile.readAsBytesSync(),
        filename: fileName,
      );
    }

    final formData = FormData(formFields);

    final response = await post(
      '${ApiEndpoint.baseUrl}${ApiEndpoint.createJobPost}',
      formData,
      headers: {
        'Authorization': 'Bearer ${token ?? ''}',
        'accept': '*/*',
      },
    );

    return response;
  }
}
