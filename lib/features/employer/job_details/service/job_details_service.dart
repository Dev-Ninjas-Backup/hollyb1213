import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/api_endpoint.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';


class JobDetailsService extends GetConnect {
  Future<Response> getJobDetails(String jobId) async {
    final token = await SharedPreferenceHelper().getAccessToken();

    final response = await get(
      '${ApiEndpoint.baseUrl}${ApiEndpoint.getJobDetails(jobId)}',
      headers: {
        'Authorization': 'Bearer ${token ?? ''}',
        'accept': '*/*',
      },
    );

    return response;
  }
}
