import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/iconpath.dart';
import 'package:readytowork/core/common/constants/widget/custom_back_button.dart';
import 'package:readytowork/core/common/constants/widget/custom_button.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/auth/payment_method/controller/payment_method_controller.dart';


class PaymentMethodScreen extends StatelessWidget {
  final PaymentMethodController controller = Get.put(PaymentMethodController());

  PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Stack(
              alignment: Alignment.topLeft,
              children: [
                CustomBackButton(),
                Center(
                  child: Text(
                    "Payment Method",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Appcolor.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Fee Info
            Center(
              child: Column(
                children: [
                  Text(
                    "Background Check Fee:",
                    style: getBodyTextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "3.99\$",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),

            // Stripe Box
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Appcolor.primaryColor, width: 1),
                color: Appcolor.appSecondaryColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        bottom: -2,
                        left: -4,
                        right: -4,
                        child: Container(
                          height: 32,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Appcolor.backgroundcolor,
                          ),
                        ),
                      ),
                      Text(
                        "Stripe",
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    Iconpath.dot,
                    height: 14,
                    width: 14,
                    color: Appcolor.primaryColor,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Stripe Card Form
            Obx(() {
              if (!controller.isStripeReady.value) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }
              return CardFormField(
                controller: controller.cardFormController,
                style: CardFormStyle(
                  borderColor: Appcolor.primaryColor,
                  borderRadius: 8,
                  borderWidth: 1,
                  textColor: Colors.black,
                  placeholderColor: Colors.grey,
                ),
              );
            }),

            SizedBox(height: 70),

            // Pay Button
            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      buttonText: "Pay & Continue",
                      onTap: controller.isButtonEnabled.value
                          ? controller.continueAction
                          : null,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
