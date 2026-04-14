import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/iconpath.dart';
import 'package:readytowork/core/common/constants/widget/custom_app_bar.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employee/profile_screen/review/controller/employee_review_controller.dart';

class EmployeeReviewPage extends StatelessWidget {
  final controller = Get.put(EmployeeReviewController());
  EmployeeReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: "Reviews", iconUrl: Iconpath.backIcon),
              SizedBox(height: 12.h),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "4.0",
                      style: getBodyTextStyle(
                        fontSize: 30.sp, // Corrected from sp(30) to 30.sp
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    RatingBarIndicator(
                      unratedColor: Appcolor.primaryColor.withValues(alpha: .5),
                      rating: 4,
                      itemBuilder: (context, index) =>
                          Icon(Icons.star, color: Appcolor.primaryColor),
                      itemCount: 5,
                      itemSize: 20.sp,
                      direction: Axis.horizontal,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "Based on 24 reviews",
                      style: getBodyTextStyle(
                        color: Appcolor.appTextSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Image.asset(
                "assets/images/reviewImage.png",
                height: 134.h,
                width: double.infinity,
              ),
              SizedBox(height: 20.h),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.allReview.length,
                itemBuilder: (_, index) {
                  final item = controller.allReview[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 25.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                                borderRadius:
                                    BorderRadiusGeometry.circular(50.r),
                                child: Image.asset(item.imageUrl,
                                    height: 38.h, width: 38.w)),
                            SizedBox(width: 4.w),
                            Text(
                              item.title,
                              style: getBodyTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            RatingBarIndicator(
                              unratedColor: Appcolor.primaryColor.withValues(
                                alpha: .5,
                              ),
                              rating: item.rating,
                              itemBuilder: (context, index) => Icon(Icons.star,
                                  color: Appcolor.primaryColor),
                              itemCount: 5,
                              itemSize: 20.sp,
                              direction: Axis.horizontal,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              item.rating.toString(),
                              style: getBodyTextStyle(
                                color: Appcolor.appTextSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          item.subTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 40.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
