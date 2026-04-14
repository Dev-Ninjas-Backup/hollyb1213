import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employee/profile_screen/profile/widgets/employee_profile_controller.dart';


class Settings extends StatelessWidget {
  final EmployeeProfileController controller;

  const Settings({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSettingItem(Icons.person_outline, "Personal Info"),
        _buildSettingItem(Icons.notifications_outlined, "Notifications"),
        _buildSettingItem(Icons.lock_outline, "Security"),
        _buildSettingItem(Icons.help_outline, "Help & Support"),
      ],
    );
  }

  Widget _buildSettingItem(IconData icon, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
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
      child: Row(
        children: [
          Icon(icon, color: Appcolor.primaryColor, size: 24.sp),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style: getBodyTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Appcolor.appTextColor,
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
        ],
      ),
    );
  }
}
