import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/widgets/employee_profile_controller.dart';

class YourStats extends StatelessWidget {
  final EmployeeProfileController controller;

  const YourStats({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard("Applied", "12"),
        _buildStatCard("Reviewed", "05"),
        _buildStatCard("Contacted", "03"),
      ],
    );
  }

  Widget _buildStatCard(String title, String count) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 15.h),
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
          Text(
            count,
            style: getTextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Appcolor.primaryColor,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            title,
            style: getBodyTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Appcolor.appTextSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
