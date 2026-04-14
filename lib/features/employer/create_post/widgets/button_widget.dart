import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employer/create_post/controller/create_post_controller.dart';


class Button extends StatelessWidget {
  const Button({super.key, required this.controller});

  final CreatePostController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed:
                  controller.isLoading.value ? null : controller.saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: controller.isLoading.value
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      "Post Job",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: OutlinedButton(
              onPressed:
                  controller.isLoading.value ? null : controller.cancelChanges,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Appcolor.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                backgroundColor: Colors.white,
              ),
              child: Text(
                "Cancel",
                style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
