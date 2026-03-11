import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/widgets/employee_profile_controller.dart';

class YourStats extends StatelessWidget {
  final EmployeeProfileController controller;

  const YourStats({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (controller.statsList.length > 0)
                _buildDynamicStatCard(
                  controller.statsList[0]['iconImage'],
                  controller.statsList[0]['count'],
                  controller.statsList[0]['completedMsg'],
                ),
              if (controller.statsList.length > 1)
                _buildDynamicStatCard(
                  controller.statsList[1]['iconImage'],
                  controller.statsList[1]['count'],
                  controller.statsList[1]['completedMsg'],
                ),
              if (controller.statsList.length > 2)
                _buildDynamicStatCard(
                  controller.statsList[2]['iconImage'],
                  controller.statsList[2]['count'],
                  controller.statsList[2]['completedMsg'],
                ),
            ],
          ),
          SizedBox(height: 12.h),
          if (controller.statsList.length > 3)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildDynamicStatCard(
                  controller.statsList[3]['iconImage'],
                  controller.statsList[3]['count'],
                  controller.statsList[3]['completedMsg'],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDynamicStatCard(String icon, String count, String title) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(
              icon,
              height: 24.h,
              width: 24.w,
            ),
            SizedBox(height: 8.h),
            Text(
              count,
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Appcolor.primaryColor,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: getBodyTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Appcolor.appTextSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
