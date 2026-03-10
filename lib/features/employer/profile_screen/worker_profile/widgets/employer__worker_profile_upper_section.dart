import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/profile_screen/worker_profile/model/employee_profile_model.dart';
import 'package:hollyb1213/routes/app_route.dart';

class EmployerWorkerProfileUpperSection extends StatelessWidget {
  final EmployeeProfileData profile;

  const EmployerWorkerProfileUpperSection({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(61.r),
          child: profile.profilePhotoUrl != null
              ? Image.network(
                  profile.profilePhotoUrl!,
                  height: 122.w,
                  width: 122.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(Imagepath.profile,
                        height: 122.w, width: 122.w);
                  },
                )
              : Image.asset(Imagepath.profile, height: 122.w, width: 122.w),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10.w,
          children: [
            Text(
              profile.user.fullName,
              style: getTextStyle(
                fontSize: sp(22),
                fontWeight: FontWeight.w600,
                color: Appcolor.appTextColor,
              ),
            ),
            Image.asset(Iconpath.profileActiveicon, height: 30.h, width: 30.w),
          ],
        ),
        SizedBox(height: 6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Iconpath.messageProfileIcon,
              height: 20.h,
              width: 20.w,
            ),
            SizedBox(width: 6.w),
            Text(
              profile.user.email,
              style: getBodyTextStyle(
                color: Appcolor.appTextSecondaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          spacing: 10.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingBarIndicator(
              unratedColor: Appcolor.primaryColor.withValues(alpha: .5),
              rating: profile.rating,
              itemBuilder: (context, index) =>
                  Icon(Icons.star, color: Appcolor.primaryColor),
              itemCount: 5,
              itemSize: sp(20),
              direction: Axis.horizontal,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.employeeReview);
              },
              child: Text(
                "${profile.rating}",
                style: getBodyTextStyle(color: Appcolor.appTextSecondaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
