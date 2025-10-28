// ... (imports remain the same)

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_back_button.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_button.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/auth/upload_passport/controller/upload_passport_controller.dart';
import 'package:hollyb1213/features/auth/upload_passport/widget/passport_box_widget.dart';
import 'package:hollyb1213/routes/app_route.dart';

class UploadPassportScreen extends StatelessWidget {
  UploadPassportScreen({super.key});

  final UploadPassportController ctrl = Get.put(UploadPassportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Stack(
              alignment: Alignment.center,
              children: [
                CustomBackButton(),
                Center(
                  child: Text(
                    "Personal Documents",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Appcolor.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Progress bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Appcolor.primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Appcolor.primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Appcolor.primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Upload Your Passport",
                style: getBodyTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Front NID Upload Box
            Obx(
              () => PassportBoxWidget(
                image: ctrl.frontImage.value,
                onPick: ctrl.pickFrontImage,
                onRemove: () => ctrl.frontImage.value = null,
                label:
                    'Front side photo of your Passport\n with your clear name and photo',
              ),
            ),

            SizedBox(height: 20),

            // Back NID Upload Box
            Obx(
              () => PassportBoxWidget(
                image: ctrl.backImage.value,
                onPick: ctrl.pickBackImage,
                onRemove: () => ctrl.backImage.value = null,
                label:
                    'Back side photo of your Passport\n with your clear name and photo',
              ),
            ),

            SizedBox(height: 80),

            // Next Button
            Obx(() {
              return CustomButton(
                buttonText: "Next",
                onTap: ctrl.isBothSelected
                    ? () {
                        Get.toNamed(AppRoute.getuploadUtilityBillScreen());
                      }
                    : null,
              );
            }),
            SizedBox(height: 20),
            Container(
              width: 370,
              height: 55,
              decoration: BoxDecoration(
                border: Border.all(color: Appcolor.primaryColor, width: 1.5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoute.getuploadUtilityBillScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.backgroundcolor,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Skip, If you don’t have Passport",
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
