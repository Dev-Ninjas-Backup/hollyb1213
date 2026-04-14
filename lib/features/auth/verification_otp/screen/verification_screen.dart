import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/widget/custom_back_button.dart';
import 'package:readytowork/core/common/constants/widget/custom_button.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/auth/verification_otp/controller/verification_conroller.dart';


class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});

  final VerificationConroller ctrl = Get.put(VerificationConroller());

  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: screenHeight - MediaQuery.of(context).padding.top,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: CustomBackButton(),
                      ),
                      Text(
                        "Verification",
                        style: getTextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w600,
                          color: Appcolor.primaryColor,
                        ),
                      ),
                    ],
                  ),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            "Code has been sent to ${ctrl.email.value}",
                            style: getBodyTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // OTP Input Fields
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) {
                            final List<TextEditingController> controllers = [
                              ctrl.digit1,
                              ctrl.digit2,
                              ctrl.digit3,
                              ctrl.digit4,
                              ctrl.digit5,
                              ctrl.digit6,
                            ];

                            return Flexible(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                constraints: BoxConstraints(
                                  maxWidth: (screenWidth - 80) / 6,
                                  maxHeight: 65,
                                ),
                                child: TextField(
                                  controller: controllers[index],
                                  focusNode: focusNodes[index],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  style: getTextStyle(
                                    fontSize: screenWidth < 360 ? 18 : 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    contentPadding: EdgeInsets.zero,
                                    filled: true,
                                    fillColor: Appcolor.appSecondaryColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Appcolor.appBorderColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Appcolor.primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    ctrl.updateOTP(index, value);
                                    if (value.isNotEmpty && index < 5) {
                                      focusNodes[index + 1].requestFocus();
                                    } else if (value.isEmpty && index > 0) {
                                      focusNodes[index - 1].requestFocus();
                                    }
                                  },
                                ),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 30),

                        Obx(
                          () => TextButton(
                            onPressed: ctrl.secondsRemaining.value == 0
                                ? () => ctrl.resendCode()
                                : null,
                            child: ctrl.secondsRemaining.value == 0
                                ? Text(
                                    "Resend code",
                                    style: getBodyTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Appcolor.primaryColor,
                                    ),
                                  )
                                : RichText(
                                    text: TextSpan(
                                      text: "Resend code in ",
                                      style: getBodyTextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "${ctrl.secondsRemaining.value}s",
                                          style: getTextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Appcolor.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Obx(
                    () => ctrl.isLoading.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: CircularProgressIndicator(
                              color: Appcolor.primaryColor,
                            ),
                          )
                        : CustomButton(
                            buttonText: "Verify",
                            onTap: ctrl.isButtonEnabled.value
                                ? () => ctrl.continueAction()
                                : null,
                          ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
