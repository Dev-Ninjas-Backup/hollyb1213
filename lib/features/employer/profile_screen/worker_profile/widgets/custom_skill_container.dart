import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';

class CustomSkillContainer extends StatelessWidget {
  final String text;
  const CustomSkillContainer({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: Appcolor.primaryColor),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: Text(
          text,
          style: getTextStyle(
            fontSize: sp(14),
            fontWeight: FontWeight.w400,
            color: Appcolor.primaryColor,
          ),
        ),
      ),
    );
  }
}
