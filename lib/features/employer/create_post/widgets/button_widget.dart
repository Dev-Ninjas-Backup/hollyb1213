import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/create_post/controller/create_post_controller.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.controller});

  final CreatePostController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: controller.saveChanges,
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            child: Text(
              "Save Changes",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: OutlinedButton(
            onPressed: controller.cancelChanges,
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
    );
  }
}
