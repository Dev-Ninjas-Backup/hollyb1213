import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/api_endpoint.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';


class PaymentService extends GetConnect {
  Future<Response> getPublishableKey() async {
    final token = await SharedPreferenceHelper().getAccessToken();
    return await get(
      ApiEndpoint.getStripePublishKey,
      headers: {
        'Authorization': 'Bearer ${token ?? ''}',
        'accept': '*/*',
      },
    );
  }

  Future<Response> processPayment({
    required String paymentMethodId,
    required String planType,
  }) async {
    final token = await SharedPreferenceHelper().getAccessToken();
    return await post(
      ApiEndpoint.stripePayment,
      {
        'planType': planType,
        'paymentMethodId': paymentMethodId,
      },
      headers: {
        'Authorization': 'Bearer ${token ?? ''}',
        'Content-Type': 'application/json',
        'accept': '*/*',
      },
    );
  }
}
