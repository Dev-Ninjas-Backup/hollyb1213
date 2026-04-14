import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readytowork/core/common/constants/iconpath.dart';
import 'package:readytowork/core/common/constants/imagepath.dart';
import 'package:readytowork/core/common/constants/widget/custom_app_bar.dart';
import 'package:readytowork/core/common/constants/widget/custom_button.dart';
import 'package:readytowork/core/common/constants/widget/custom_text_field.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employee/profile_screen/profile_info/controller/employee_profile_info_controller.dart';

class EmployeeProfileInfoPage extends StatelessWidget {
  final controller = Get.put(EmployeeProfileInfoController());
  EmployeeProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(
                          title: "Profile Info", iconUrl: Iconpath.backIcon),
                      SizedBox(height: 24.h),
                      Center(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(61.r),
                              child: Obx(
                                () => controller.selectedImage.value != null
                                    ? Image.file(
                                        controller.selectedImage.value!,
                                        height: 122.w,
                                        width: 122.w,
                                        fit: BoxFit.cover,
                                      )
                                    : controller
                                            .profilePhotoUrl.value.isNotEmpty
                                        ? Image.network(
                                            controller.profilePhotoUrl.value,
                                            height: 122.w,
                                            width: 122.w,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                Imagepath.profile,
                                                height: 122.w,
                                                width: 122.w,
                                              );
                                            },
                                          )
                                        : Image.asset(
                                            Imagepath.profile,
                                            height: 122.w,
                                            width: 122.w,
                                          ),
                              ),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 1.1,
                              child: GestureDetector(
                                onTap: () {
                                  controller.pickImage(ImageSource.gallery);
                                },
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
                        hintText: "Nicolas",
                      ),
                      CustomTextField(
                        controller: controller.phoneNumberController,
                        lebelText: "Phone Number",
                        hintText: "+1 (555) 123-4567",
                      ),
                      CustomTextField(
                        controller: controller.addressController,
                        lebelText: "Address",
                        hintText: "House #5, Dhaka Bangladesh",
                      ),
                      CustomTextField(
                        controller: controller.dobController,
                        lebelText: "Date of Birth",
                        hintText: "2000-01-01",
                      ),
                      CustomTextField(
                        controller: controller.experienceYearsController,
                        lebelText: "Experience Years",
                        hintText: "5",
                      ),
                      CustomTextField(
                        controller: controller.skillController,
                        lebelText: "Skills",
                        hintText:
                            "Cleaning, waiter, Kitchen Assistant Kitchen Helper",
                      ),
                      SizedBox(height: 30.h),
                      CustomButton(
                        buttonText: "Save Changes",
                        onTap: () {
                          controller.updateProfile();
                        },
                      ),
                      SizedBox(height: 30.h),
                      GestureDetector(
                        onTap: () {
                          _showDeleteConfirmation(context, controller);
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
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, EmployeeProfileInfoController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Delete Account",
          style: getBodyTextStyle(
            fontSize: sp(18),
            fontWeight: FontWeight.w600,
            color: Color(0xFFFF2F2F),
          ),
        ),
        content: Text(
          "Are you sure you want to permanently delete your account? This action cannot be undone.",
          style: getTextStyle(fontSize: sp(14)),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "Cancel",
              style: getTextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteProfile();
            },
            child: Text(
              "Delete",
              style: getTextStyle(color: Color(0xFFFF2F2F)),
            ),
          ),
        ],
      ),
    );
  }
}
