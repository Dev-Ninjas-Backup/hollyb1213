import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/profile_screen/worker_profile/screen/employer_worker_profile.dart';

class ProfileUpperSection extends StatelessWidget {
  const ProfileUpperSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Profile',
            style: getTextStyle(fontSize: sp(20), fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 24.h),
// for demo it will nevigate different tab
        GestureDetector(
          onTap: () {
            Get.to(EmployerWorkerProfile());
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(61.r),
            child: Image.asset(Imagepath.profile, height: 122.w, width: 122.w),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10.w,
          children: [
            Text(
              "Marina Budarina",
              style: getTextStyle(
                fontSize: sp(22),
                fontWeight: FontWeight.w600,
                color: Appcolor.appTextColor,
              ),
            ),
            // SizedBox(height: 20.w,),
            Image.asset(Iconpath.profileActiveicon, height: 30.h, width: 30.w),
          ],
        ),
        SizedBox(height: 6.h),

        Text("Carter's Grill & Cafe", style: getBodyTextStyle()),
        SizedBox(height: 6.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on_outlined, size: sp(20)),
            SizedBox(width: 12.w),
            Text("Mesa, New Jerse", style: getBodyTextStyle()),
          ],
        ),
      ],
    );
  }
}
