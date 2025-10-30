import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_app_bar.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';

class EmployeePrivacy extends StatelessWidget {
  const EmployeePrivacy({super.key});

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
              CustomAppBar(
                title: "Privacy & privacy",
                iconUrl: Iconpath.backIcon,
              ),
              SizedBox(height: 30.h),
              Text(
                "Data We Collect:",
                style: getBodyTextStyle(
                  fontSize: sp(12),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "When you use our app, we only collect the details needed to make your journey smooth. This includes your basic profile information, your EV details so we can track charging status, your location to guide you to nearby stations, and payment details to ensure secure transactions. Nothing extra, just the essentials to keep your charging experience easy and safe.",
                style: getBodyTextStyle(
                  fontSize: sp(12),
                  color: Appcolor.appTextSecondaryColor,
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                "How We Use It:",
                style: getBodyTextStyle(
                  fontSize: sp(12),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "When you use our app, we only collect the details needed to make your journey smooth. This includes your basic profile information, your EV details so we can track charging status, your location to guide you to nearby stations, and payment details to ensure secure transactions. Nothing extra, just the essentials to keep your charging experience easy and safe.",
                style: getBodyTextStyle(
                  fontSize: sp(12),
                  color: Appcolor.appTextSecondaryColor,
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                "Your Safety:",
                style: getBodyTextStyle(
                  fontSize: sp(12),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "When you use our app, we only collect the details needed to make your journey smooth. This includes your basic profile information, your EV details so we can track charging status, your location to guide you to nearby stations, and payment details to ensure secure transactions. Nothing extra, just the essentials to keep your charging experience easy and safe.",
                style: getBodyTextStyle(
                  fontSize: sp(12),
                  color: Appcolor.appTextSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
