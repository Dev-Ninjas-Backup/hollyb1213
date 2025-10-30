import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';

class ProfileUpperSection extends StatelessWidget {
  const ProfileUpperSection({
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
    
        ClipRRect(
          borderRadius: BorderRadius.circular(61.r),
          child: Image.asset(
            Imagepath.profile,
            height: 122.w,
            width: 122.w,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10.w,
          children: [
            Text(
              "Nicolas",
              style: getTextStyle(
                fontSize: sp(22),
                fontWeight: FontWeight.w600,
                color: Appcolor.appTextColor,
              ),
            ),
            // SizedBox(height: 20.w,),
            Image.asset(
              Iconpath.profileActiveicon,
              height: 30.h,
              width: 30.w,
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
    
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
                  "nicolas@email.com",
                  style: getBodyTextStyle(
                    color: Appcolor.appTextSecondaryColor,
                  ),
                ),
              ],
            ),
    
            Row(
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
              rating: 4,
              itemBuilder: (context, index) =>
                  Icon(Icons.star, color: Appcolor.primaryColor),
              itemCount: 5,
              itemSize: sp(20),
              direction: Axis.horizontal,
            ),
            Text(
              "4.8 (24 review)",
              style: getBodyTextStyle(
                color: Appcolor.appTextSecondaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
