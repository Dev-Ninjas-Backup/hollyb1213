import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/widgets/employee_profile_controller.dart';

import 'package:hollyb1213/features/employee/profile_screen/profile/widgets/profile_upper_section.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/widgets/settings.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/widgets/your_stats.dart';

class EmployeeProfileScreen extends StatelessWidget {
  EmployeeProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final EmployeeProfileController controller =
        Get.put(EmployeeProfileController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.fetchUserProfile(),
          child: Obx(() {
            if (controller.isLoading.value &&
                controller.userProfile.value == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.userProfile.value == null) {
              return const Center(child: Text('Could not load profile.'));
            }
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  ProfileUpperSection(
                      userProfile: controller.userProfile.value!),
                  SizedBox(height: 30.h),
                  Text(
                    "Your Stats",
                    style: getBodyTextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  YourStats(controller: controller),
                  SizedBox(height: 30.h),
                  Text(
                    "Settings",
                    style: getBodyTextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Settings(controller: controller),
                  SizedBox(height: 20.h),
                  Center(
                    child: GestureDetector(
                      onTap: () => controller.logout(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(Iconpath.signOut,
                              height: 40.h, width: 40.w),
                          SizedBox(width: 8.w),
                          Text(
                            "Sign Out",
                            style: getBodyTextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFF2F2F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
