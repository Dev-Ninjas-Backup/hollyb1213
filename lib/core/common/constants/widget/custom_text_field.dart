import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';

class CustomTextField extends StatelessWidget {
  final String lebelText;
  final String hintText;
  final bool obscureText;
  final int? maxLine;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextEditingController controller;

  const CustomTextField({
    required this.controller,
    required this.lebelText,
    this.suffixIcon,
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(lebelText, style: getTextStyle(color: Appcolor.appTextColor,fontSize: sp(14),fontWeight: FontWeight.w500)),

          Container(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Appcolor.appSecondaryColor,
              borderRadius: BorderRadius.circular(12.r),

             // border: Border.all(color: Appcolor.appBodyColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    obscureText: obscureText,
                    // maxLines: maxLine,
                    maxLines: obscureText ? 1 : null,
                    validator: validator,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: getBodyTextStyle(),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                  ),
                ),
                if (suffixIcon != null) suffixIcon!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
