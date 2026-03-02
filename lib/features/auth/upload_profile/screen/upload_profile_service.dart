// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UploadProfileService extends GetConnect {
//   Future<Response> uploadProfilePhoto(File file) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');

//     final formData = FormData({
//       'file': MultipartFile(file, filename: file.path.split('/').last),
//     });

//     final response = await post(
//       ApiEndpoint.profilePhoto,
//       formData,
//       headers: {'Authorization': 'Bearer $token'},
//     );
//     return response;
//   }
// }
