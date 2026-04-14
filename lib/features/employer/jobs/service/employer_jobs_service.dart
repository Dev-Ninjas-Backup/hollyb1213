import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/api_endpoint.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';

class EmployerJobsService extends GetConnect {
  Future<Response> getPostedJobs({
    required String status,
    required bool isUrgent,
    required int page,
    required int limit,
  }) async {
    final token = await SharedPreferenceHelper().getAccessToken();

    final response = await get(
      ApiEndpoint.getMyPostedJobs(status, isUrgent, page, limit),
      headers: {
        'Authorization': 'Bearer ${token ?? ''}',
        'accept': '*/*',
      },
    );

    return response;
  }
}
