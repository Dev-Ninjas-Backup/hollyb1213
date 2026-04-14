import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';

class Information extends StatelessWidget {
  final dynamic profile;

  const Information({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 20.sp,
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
              size: 20.sp,
              color: Appcolor.appTextSecondaryColor,
            ),
            SizedBox(width: 4.w),
            Text(
              "Experience: ${profile.experienceYears} Years",
              style: getBodyTextStyle(color: Appcolor.appTextSecondaryColor),
            ),
          ],
        ),
        if (profile.user.phone != null && profile.user.phone!.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                size: 20.sp,
                color: Appcolor.appTextSecondaryColor,
              ),
              SizedBox(width: 4.w),
              Text(
                profile.user.phone!,
                style: getBodyTextStyle(color: Appcolor.appTextSecondaryColor),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
