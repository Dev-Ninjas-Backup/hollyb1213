// ... (imports remain the same)

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/widget/custom_back_button.dart';
import 'package:readytowork/core/common/constants/widget/custom_button.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/auth/upload_nid/controller/upload_nid_controller.dart';
import 'package:readytowork/features/auth/upload_nid/widgets/nid_box_widget.dart';


class UploadNidScreen extends StatelessWidget {
  UploadNidScreen({super.key});

  final UploadNidController ctrl = Get.put(UploadNidController());

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
                      color: Colors.grey[200],
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
                "Upload Your NID Card",
                style: getBodyTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Front NID Upload Box
            Obx(
              () => BoxNid(
                image: ctrl.frontImage.value,
                onPick: ctrl.pickFrontImage,
                onRemove: () => ctrl.frontImage.value = null,
                label:
                    'Front side photo of your NID with your\n clear name and photo',
              ),
            ),

            SizedBox(height: 20),

            // Back NID Upload Box
            Obx(
              () => BoxNid(
                image: ctrl.backImage.value,
                onPick: ctrl.pickBackImage,
                onRemove: () => ctrl.backImage.value = null,
                label:
                    'Back side photo of your NID with your\n clear name and photo',
              ),
            ),

            SizedBox(height: 110),

            // Next Button
            Obx(() {
              return ctrl.isLoading.value
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      buttonText: "Next",
                      onTap: ctrl.isBothSelected ? ctrl.uploadNid : null,
                    );
            }),
          ],
        ),
      ),
    );
  }
}
