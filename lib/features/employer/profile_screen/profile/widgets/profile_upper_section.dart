import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/profile_screen/worker_profile/screen/employer_worker_profile.dart';
import 'package:hollyb1213/features/employer/profile_screen/profile/controller/employer_controllre.dart';

class ProfileUpperSection extends StatelessWidget {
  final EmployerProfileController controller;
  const ProfileUpperSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Center(
              child: Text(
                'Profile',
                style:
                    getTextStyle(fontSize: sp(20), fontWeight: FontWeight.w600),
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
                child: controller
                            .employerProfile.value?.profile?.profilePhotoUrl !=
                        null
                    ? Image.network(
                        controller
                            .employerProfile.value!.profile!.profilePhotoUrl!,
                        height: 122.w,
                        width: 122.w,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(Imagepath.profile,
                              height: 122.w, width: 122.w);
                        },
                      )
                    : Image.asset(Imagepath.profile,
                        height: 122.w, width: 122.w),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.w,
              children: [
                Text(
                  controller.employerProfile.value?.fullName ?? "Loading...",
                  style: getTextStyle(
                    fontSize: sp(22),
                    fontWeight: FontWeight.w600,
                    color: Appcolor.appTextColor,
                  ),
                ),
                // SizedBox(height: 20.w,),
                Image.asset(Iconpath.profileActiveicon,
                    height: 30.h, width: 30.w),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              controller.employerProfile.value?.profile?.companyName ??
                  "Company Name",
              style: getBodyTextStyle(),
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_outlined, size: sp(20)),
                SizedBox(width: 12.w),
                Text(
                  controller.employerProfile.value?.profile?.address ??
                      "Location",
                  style: getBodyTextStyle(),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withValues(alpha: .11),
                      offset: Offset(0, 0),
                      blurRadius: 10.r,
                      spreadRadius: 0.r,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "VIP Features Activated",
                      style: getBodyTextStyle(
                        fontSize: sp(18),
                        fontWeight: FontWeight.w600,
                        color: Appcolor.appTextColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Joining Date: Jul 15, 2025",
                      style: getBodyTextStyle(
                        fontSize: sp(12),
                        fontWeight: FontWeight.w400,
                        color: Appcolor.appTextColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// 🔥 Prevent overflow
                        Expanded(
                          child: Text(
                            "Expiry Date: Aug 15, 2025",
                            style: getTextStyle(
                              fontSize: sp(12),
                              fontWeight: FontWeight.w400,
                              color: Appcolor.appTextColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        SizedBox(width: 8.w),

                        /// 🔥 Status Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(70, 255, 0, 4),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // ✅ important
                            children: [
                              Container(
                                height: 6.h,
                                width: 6.w,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                "Expired",
                                style: getBodyTextStyle(
                                  fontSize: sp(12),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    GestureDetector(
                      onTap: () {
                        // Handle tap event
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          color: Color(0xFFE0E0E0),
                        ),
                        child: Text(
                          "Renew Subscription",
                          style: getBodyTextStyle(
                            fontSize: sp(14),
                            fontWeight: FontWeight.w400,
                            color: Appcolor.appTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
