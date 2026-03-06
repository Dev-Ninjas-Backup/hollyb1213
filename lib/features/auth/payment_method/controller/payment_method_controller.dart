// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/auth/payment_method/service/payment_service.dart';
import 'package:hollyb1213/routes/app_route.dart';

class PaymentMethodController extends GetxController {
  final cardFormController = CardFormEditController();

  var isButtonEnabled = false.obs;
  var isLoading = false.obs;
  var isStripeReady = false.obs;

  final PaymentService _service = PaymentService();

  @override
  void onInit() {
    super.onInit();
    cardFormController.addListener(_validateForm);
    _initStripe();
  }

  Future<void> _initStripe() async {
    try {
      final response = await _service.getPublishableKey();
      print('Stripe Key Response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200 && response.body['success'] == true) {
        final publishableKey = response.body['data']['publishableKey'];
        Stripe.publishableKey = publishableKey;
        await Stripe.instance.applySettings();
        isStripeReady.value = true;
        print('Stripe initialized with key: $publishableKey');
      } else {
        print('Failed to fetch Stripe publishable key');
      }
    } catch (e) {
      print('Stripe init error: $e');
    }
  }

  void _validateForm() {
    isButtonEnabled.value = cardFormController.details.complete;
  }

  @override
  void onClose() {
    cardFormController.dispose();
    super.onClose();
  }

  Future<void> continueAction() async {
    if (!isButtonEnabled.value) return;

    isLoading.value = true;
    try {
      // Create PaymentMethod from the CardFormField data
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      final paymentMethodId = paymentMethod.id;
      print('PaymentMethod ID: $paymentMethodId');

      // Determine plan type based on selected role
      final role = await SharedPreferenceHelper().getSelectedRole();
      final planType =
          role == 'employee' ? 'employee_premium' : 'employer_premium';

      // Send to backend
      final response = await _service.processPayment(
        paymentMethodId: paymentMethodId,
        planType: planType,
      );

      print('Payment Response: ${response.statusCode}');
      print('Payment Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body['success'] == true) {
          _showSuccessDialog(role ?? 'employee');
        } else {
          final message =
              response.body['message'] ?? 'Payment failed. Please try again.';
          Get.snackbar('Payment Failed', message,
              snackPosition: SnackPosition.TOP);
        }
      } else {
        final message =
            response.body?['message'] ?? 'Payment failed. Please try again.';
        Get.snackbar('Payment Failed', message,
            snackPosition: SnackPosition.TOP);
      }
    } on StripeException catch (e) {
      print('Stripe error: ${e.error.message}');
      Get.snackbar(
        'Payment Error',
        e.error.message ?? 'Card error. Please check your card details.',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      print('Payment error: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _showSuccessDialog(String role) {
    Get.dialog(
      Dialog(
        backgroundColor: Appcolor.backgroundcolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            SizedBox(
              width: 307,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Appcolor.primaryColor,
                          width: 30,
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          Iconpath.vector2,
                          height: 13,
                          width: 14,
                          color: Appcolor.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Congratulations!",
                      style: getTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Payment successful. Your account has been verified and activated for job access.",
                      style: getBodyTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: 188,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (role == 'employee') {
                            Get.offAllNamed(
                                AppRoute.getEmployeeBottomNavbarScreen());
                          } else {
                            Get.offAllNamed(
                                AppRoute.getemployerBottomNavbarScreen());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.primaryColor,
                        ),
                        child: Text(
                          'Go to Home',
                          style: getTextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
