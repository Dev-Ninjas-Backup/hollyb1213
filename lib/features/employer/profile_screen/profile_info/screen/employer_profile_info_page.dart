import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_app_bar.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_button.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_text_field.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/profile_screen/profile_info/controller/employer_profile_info_controller.dart';

class EmployerProfileInfoPage extends StatelessWidget {
  final controller = Get.put(EmployerProfileInfoController());
  EmployerProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: "Profile Info", iconUrl: Iconpath.backIcon),
              SizedBox(height: 24.h),
              Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(61.r),
                      child: Image.asset(
                        Imagepath.profile,
                        height: 122.w,
                        width: 122.w,
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 1.1,

                      child: GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          Iconpath.editicon,
                          height: 40.h,
                          width: 40.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
              Text(
                "Personal Details",
                style: getBodyTextStyle(
                  fontSize: sp(20),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),

              CustomTextField(
                controller: controller.fullNameController,
                lebelText: "Full name",
                hintText: "Marina Budarina",
              ),

              CustomTextField(
                controller: controller.fullNameController,
                lebelText: "Company  Name",
                hintText: "Carter's Grill & Cafe",
              ),

              CustomTextField(
                controller: controller.fullNameController,
                lebelText: "Phone Number",
                hintText: "+1 (555) 123-4567",
              ),
              CustomTextField(
                controller: controller.fullNameController,
                lebelText: "Address",
                hintText: "House #5, Dhaka Bangladesh",
              ),
              CustomTextField(
                controller: controller.fullNameController,
                lebelText: "Date of Birth",
                hintText: "12 may 1999",
              ),
              // CustomTextField(
              //   controller: controller.fullNameController,
              //   lebelText: "Date of Birth",
              //   hintText: "12 may 1999",
              // ),

              SizedBox(height: 30.h),
              CustomButton(buttonText: "Save Changes", onTap: () {}),
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: () {
                  //  Get.offAll(RoleSelectionScreen());
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/delete.png",
                      height: 40.h,
                      width: 40.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Delete Account",
                      style: getTextStyle(color: Color(0xFFFF2F2F)),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
