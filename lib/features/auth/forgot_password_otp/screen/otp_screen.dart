import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/widget/custom_back_button.dart';
import 'package:readytowork/core/common/constants/widget/custom_button.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/auth/forgot_password_otp/controller/otp_controller.dart';
import 'package:readytowork/routes/app_route.dart';


class OTPScreen extends StatelessWidget {
  OTPScreen({super.key});

  final OTPController ctrl = Get.put(OTPController());

  final FocusNode focus1 = FocusNode();
  final FocusNode focus2 = FocusNode();
  final FocusNode focus3 = FocusNode();
  final FocusNode focus4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 70),
            Stack(
              alignment: Alignment.center,
              children: [
                CustomBackButton(),
                Center(
                  child: Text(
                    "Forgot Password",
                    style: getTextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Appcolor.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Code has been sent to +1 111 ******99",
                    style: getBodyTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      final controllers = [
                        ctrl.digit1,
                        ctrl.digit2,
                        ctrl.digit3,
                        ctrl.digit4,
                      ];
                      final focuses = [focus1, focus2, focus3, focus4];

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: 60,
                          height: 65,
                          child: TextField(
                            controller: controllers[index],
                            focusNode: focuses[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: getTextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Appcolor.primaryColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Appcolor.primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              ctrl.updateOTP(index, value);

                              if (value.isNotEmpty && index < 3) {
                                focuses[index + 1].requestFocus();
                              } else if (value.isEmpty && index > 0) {
                                focuses[index - 1].requestFocus();
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20),
                  Obx(
                    () => TextButton(
                      onPressed: ctrl.secondsRemaining.value == 0
                          ? ctrl.resendCode
                          : null,
                      child: ctrl.secondsRemaining.value == 0
                          ? Text(
                              "Resend code",
                              style: getBodyTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
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
                                    text: "${ctrl.secondsRemaining.value}s",
                                    style: getTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
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

            CustomButton(
              buttonText: "Verify",
              onTap: () {
                Get.toNamed(AppRoute.getcreatePasswordScreen());
              },
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
