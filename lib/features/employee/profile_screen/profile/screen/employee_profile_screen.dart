import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/routes/app_route.dart';

import 'package:hollyb1213/features/employee/profile_screen/profile/controller/employee_controllre.dart';

import 'package:hollyb1213/features/employee/profile_screen/profile/widgets/profile_upper_section.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/widgets/settings.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/widgets/your_stats.dart';

class EmployeeProfileScreen extends StatelessWidget {
  final controller = Get.put(EmployeeProfileController());
  EmployeeProfileScreen({super.key});
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
              SizedBox(height: 63.h),
              ProfileUpperSection(),
              SizedBox(height: 30.h),
              Text(
                "Your Stats",
                style: getBodyTextStyle(
                  fontSize: sp(20),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),
              YourStats(controller: controller),
              SizedBox(height: 30.h),
              Text(
                "Settings",
                style: getBodyTextStyle(
                  fontSize: sp(20),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),
              Settings(controller: controller),
              SizedBox(height: 20.h),
              Center(
                child: GestureDetector(
                  onTap: () => Get.offAllNamed(AppRoute.getroleSelection()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Iconpath.signOut, height: 40.h, width: 40.w),
                      SizedBox(width: 8.w),
                      Text(
                        "Sign Out",
                        style: getBodyTextStyle(
                          fontSize: sp(16),
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFF2F2F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
