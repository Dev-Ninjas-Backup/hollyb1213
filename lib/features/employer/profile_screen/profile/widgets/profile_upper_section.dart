import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/iconpath.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employee/profile_screen/profile/widgets/user_profile_model.dart';
import 'package:readytowork/routes/app_route.dart';

class ProfileUpperSection extends StatelessWidget {
  final UserProfile userProfile;
  const ProfileUpperSection({
    required this.userProfile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Profile',
            style: getTextStyle(
              fontSize: sp(20),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 24.h),
        CircleAvatar(
          radius: 61.r,
          backgroundColor: Appcolor.appSecondaryColor,
          backgroundImage: userProfile.profile.profilePhotoUrl != null
              ? NetworkImage(userProfile.profile.profilePhotoUrl!)
              : null,
          child: userProfile.profile.profilePhotoUrl == null
              ? Icon(Icons.person, size: 60.r, color: Colors.grey)
              : null,
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userProfile.fullName,
              style: getTextStyle(
                fontSize: sp(22),
                fontWeight: FontWeight.w600,
                color: Appcolor.appTextColor,
              ),
            ),
            SizedBox(width: 10.w),
            Image.asset(
              Iconpath.profileActiveicon,
              height: 30.h,
              width: 30.w,
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  Iconpath.messageProfileIcon,
                  height: 20.h,
                  width: 20.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  userProfile.email,
                  style: getBodyTextStyle(
                    color: Appcolor.appTextSecondaryColor,
                  ),
                ),
              ],
            ),

            // Phone number is not available in the get-me API response.
            /* Row(
              children: [
                Image.asset(
                  Iconpath.callIcon,
                  height: 20.h,
                  width: 20.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  "+1 (555) 5356454",
                  style: getBodyTextStyle(
                    color: Appcolor.appTextSecondaryColor,
                  ),
                ),
              ],
            ), */
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingBarIndicator(
              unratedColor: Appcolor.primaryColor.withValues(alpha: .5),
              rating: userProfile.rating,
              itemBuilder: (context, index) =>
                  Icon(Icons.star, color: Appcolor.primaryColor),
              itemCount: 5,
              itemSize: sp(20),
              direction: Axis.horizontal,
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.employeeReview);
              },
              child: Text(
                "${userProfile.rating.toStringAsFixed(1)} (${userProfile.totalReviews} review${userProfile.totalReviews != 1 ? 's' : ''})",
                style: getBodyTextStyle(
                  color: Appcolor.appTextSecondaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}