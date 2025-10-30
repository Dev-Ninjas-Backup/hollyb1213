import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String iconUrl; 
  final VoidCallback? onBackTap;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.iconUrl,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 63.h, left: 16.w, right: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onBackTap ?? () => Get.back(),
            child: Image.asset(
              iconUrl,
              height: 40.h,
              width: 40.w,
            ),
          ),

          Text(
            title,
            style: getTextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(
            height: 40.h,
            width: 40.w,
          ),
        ],
      ),
    );
  }
}
