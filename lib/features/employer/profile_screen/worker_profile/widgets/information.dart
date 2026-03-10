import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/profile_screen/worker_profile/model/employee_profile_model.dart';

class Information extends StatelessWidget {
  final EmployeeProfileData profile;

  const Information({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: sp(20),
              color: Appcolor.appTextSecondaryColor,
            ),
            SizedBox(width: 4.w),
            Text(
              profile.address,
              style: getBodyTextStyle(color: Appcolor.appTextSecondaryColor),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Icon(
              Icons.work_outline_sharp,
              size: sp(20),
              color: Appcolor.appTextSecondaryColor,
            ),
            SizedBox(width: 4.w),
            Text(
              "Experience: ${profile.experienceYears} Years",
              style: getBodyTextStyle(color: Appcolor.appTextSecondaryColor),
            ),
          ],
        ),
      ],
    );
  }
}
