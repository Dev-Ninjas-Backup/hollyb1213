import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';

class Information extends StatelessWidget {
  const Information({super.key});

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
              "Dhaka Bangladesh",
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
              "Experience: 2 Years",
              style: getBodyTextStyle(color: Appcolor.appTextSecondaryColor),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Icon(
              Icons.timer_outlined,
              size: sp(20),
              color: Appcolor.appTextSecondaryColor,
            ),
            SizedBox(width: 4.w),
            Text(
              "Job Type: Part - Time / Full Time / Hourly",
              style: getBodyTextStyle(color: Appcolor.appTextSecondaryColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ],
    );
  }
}