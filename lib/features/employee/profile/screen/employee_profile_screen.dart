import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_shadow_container.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employee/profile/controller/employee_controllre.dart';
import 'package:hollyb1213/features/employee/profile/widgets/profile_upper_section.dart';
import 'package:hollyb1213/features/employee/profile/widgets/your_stats.dart';

class EmployeeProfileScreen extends StatelessWidget {
  final controller = Get.put(EmployeeProfileControllre());
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

             // CustomShadowContainer(child: child)


            ],
          ),
        ),
      ),
    );
  }
}
