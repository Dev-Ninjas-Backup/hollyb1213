import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_back_button.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_button.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/auth/upload_nid/controller/upload_nid_controller.dart';

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

            //  Updated Dotted Upload Box
            DottedBorder(
              color: Appcolor.primaryColor,
              strokeWidth: 2.2,
              dashPattern: [8, 5],
              borderType: BorderType.RRect,
              radius: Radius.circular(10),
              child: Container(
                width: double.infinity,
                height: 175,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Iconpath.nid, height: 41, width: 72),
                    SizedBox(height: 10),
                    Text(
                      'Front side photo of your NID with your\n clear name and photo',
                      textAlign: TextAlign.center,
                      style: getBodyTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: ctrl.pickImage,
                      icon: Icon(
                        Icons.camera_alt,
                        size: 22,
                        color: Appcolor.primaryColor,
                      ),
                      label: Text(
                        'Upload Photo',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          color: Appcolor.primaryColor,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),
            //  Updated Dotted Upload Box-----2
            DottedBorder(
              color: Appcolor.primaryColor,
              strokeWidth: 2.2,
              dashPattern: [8, 5],
              borderType: BorderType.RRect,
              radius: Radius.circular(10),
              child: Container(
                width: double.infinity,
                height: 175,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Iconpath.nid, height: 41, width: 72),
                    SizedBox(height: 10),
                    Text(
                      'Front side photo of your NID with your\n clear name and photo',
                      textAlign: TextAlign.center,
                      style: getBodyTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: ctrl.pickImage,
                      icon: Icon(
                        Icons.camera_alt,
                        size: 22,
                        color: Appcolor.primaryColor,
                      ),
                      label: Text(
                        'Upload Photo',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          color: Appcolor.primaryColor,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 110),

            // Next Button
            CustomButton(buttonText: "Next", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
