import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';

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

  Future<Response> processPayment({required String paymentMethodId}) async {
    final token = await SharedPreferenceHelper().getAccessToken();
    return await post(
      ApiEndpoint.stripePayment,
      {
        'planType': 'employer_premium',
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
