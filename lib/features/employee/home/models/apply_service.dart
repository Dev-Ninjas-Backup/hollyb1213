import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/api_endpoint.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';


class ApplyService extends GetConnect {
  Future<Response> applyJob({
    required String jobId,
    required String coverNote,
  }) async {
    final token = await SharedPreferenceHelper().getAccessToken();
    final url = '${ApiEndpoint.baseUrl}${ApiEndpoint.applyJob(jobId)}';

    return await post(
      url,
      {
        'cover_note': coverNote,
      },
      headers: {
        'Authorization': 'Bearer ${token ?? ''}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }
}
