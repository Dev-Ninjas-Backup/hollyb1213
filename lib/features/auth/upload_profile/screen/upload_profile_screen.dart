// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/iconpath.dart';
import 'package:readytowork/core/common/constants/imagepath.dart';
import 'package:readytowork/core/common/constants/widget/custom_back_button.dart';
import 'package:readytowork/core/common/constants/widget/custom_button.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/auth/upload_profile/controller/upload_profile_controller.dart';


class UploadProfileScreen extends StatelessWidget {
  UploadProfileScreen({super.key});

  final UploadProfileController ctrl = Get.put(UploadProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
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

            // Profile Image (Reactive)
            Obx(() {
              return SizedBox(
                height: 144,
                width: 144,
                child: CircleAvatar(
                  radius: 72,
                  backgroundColor: Appcolor.primaryColor,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: ctrl.image.value != null
                        ? FileImage(ctrl.image.value!)
                        : AssetImage(Imagepath.profile) as ImageProvider,
                  ),
                ),
              );
            }),

            SizedBox(height: 30),
            Text(
              'Make sure your face is clearly visible. Avoid sunglasses or hats.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30),

            // Upload Box
            DottedBorder(
              color: Appcolor.primaryColor,
              strokeWidth: 2.3,
              dashPattern: [8, 5],
              borderType: BorderType.RRect,
              radius: Radius.circular(10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(40),
                child: Column(
                  children: [
                    Image.asset(
                      Iconpath.upload,
                      height: 24,
                      width: 24,
                      color: Appcolor.primaryColor,
                    ),
                    SizedBox(height: 10),
                    Text('Please Upload a Profile Picture'),
                    SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: ctrl.pickImage,
                      icon: Icon(
                        Icons.camera_alt,
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
                        foregroundColor: Appcolor.primaryColor,
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

            // Next Button (enabled only if image uploaded)
            Obx(() {
              return ctrl.isLoading.value
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      buttonText: "Next",
                      onTap: ctrl.image.value != null
                          ? ctrl.uploadProfilePhoto
                          : null,
                    );
            }),
          ],
        ),
      ),
    );
  }
}
