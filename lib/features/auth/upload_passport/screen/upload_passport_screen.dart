import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_back_button.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_button.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/auth/upload_nid/widgets/nid_box_widget.dart';
import 'package:hollyb1213/features/auth/upload_passport/controller/upload_passport_controller.dart';

class UploadPassportScreen extends StatelessWidget {
  UploadPassportScreen({super.key});

  final UploadPassportController ctrl = Get.put(UploadPassportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
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
            const SizedBox(height: 24),

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
                const SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Appcolor.primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Appcolor.primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
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

            const SizedBox(height: 50),
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
            const SizedBox(height: 20),

            // Front Passport Upload Box
            Obx(
              () => BoxNid(
                image: ctrl.frontImage.value,
                onPick: ctrl.pickFrontImage,
                onRemove: () => ctrl.frontImage.value = null,
                label: 'Upload a clear photo of your passport\'s\n main page (front).',
              ),
            ),

            const SizedBox(height: 20),

            // Back Passport Upload Box
            Obx(
              () => BoxNid(
                image: ctrl.backImage.value,
                onPick: ctrl.pickBackImage,
                onRemove: () => ctrl.backImage.value = null,
                label: 'Upload the back page of your passport.',
              ),
            ),

            const SizedBox(height: 20),

            // Skip button
            TextButton(
              onPressed: () {
                // Navigate to the main dashboard, removing all previous routes
                Get.offAllNamed('/employee/dashboard');
              },
              child: Text(
                "I don't have a passport",
                style: getBodyTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Appcolor.primaryColor,
                ),
              ),
            ),

            const SizedBox(height: 110),

            Obx(() {
              return ctrl.isLoading.value
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      buttonText: "Next",
                      onTap: ctrl.isBothSelected ? ctrl.uploadPassport : null,
                    );
            }),
          ],
        ),
      ),
    );
  }
}
