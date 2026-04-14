import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/widget/custom_back_button.dart';
import 'package:readytowork/core/common/constants/widget/custom_button.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/auth/upload_utility_bill/controller/upload_utility_bill_controller.dart';
import 'package:readytowork/features/auth/upload_utility_bill/widget/utility_bill_box_widget.dart';


class UploadUtilityBillScreen extends StatelessWidget {
  UploadUtilityBillScreen({super.key});

  final UploadUtilityBillController ctrl = Get.put(
    UploadUtilityBillController(),
  );
  final TextEditingController addressController = TextEditingController();
  final TextEditingController refNameController = TextEditingController();
  final TextEditingController refNumberController = TextEditingController();

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

            /// Progress bar
            Row(
              children: List.generate(
                4,
                (_) => Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 4),
                    height: 8,
                    decoration: BoxDecoration(
                      color: Appcolor.primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Upload Your Utility Bill",
                style: getBodyTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20),

            /// Upload Box
            Obx(
              () => UtilityBillBoxWidget(
                image: ctrl.backImage.value,
                onPick: ctrl.pickBackImage,
                onRemove: ctrl.removeBackImage,
                label: 'Upload your Utility Bill Photo',
              ),
            ),

            SizedBox(height: 40),

            /// Address & Reference Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Appcolor.appSecondaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Address",
                    style: getBodyTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),

                  /// Address Input
                  TextField(
                    controller: addressController,
                    onChanged: (value) =>
                        ctrl.address.value = value, // Track input
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                      ),
                      hintText: "Enter your address",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Appcolor.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            Obx(() {
              return ctrl.isLoading.value
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      buttonText: "Submit",
                      onTap:
                          ctrl.isSubmitEnabled ? ctrl.uploadUtilityBill : null,
                    );
            }),
          ],
        ),
      ),
    );
  }
}
