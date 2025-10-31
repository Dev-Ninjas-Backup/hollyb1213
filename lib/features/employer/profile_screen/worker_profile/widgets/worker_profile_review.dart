import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import '../../../../../core/common/constants/widget/custom_shadow_container.dart';
import '../../../../../core/common/style/global_text_style.dart';
import '../../review/controller/employer_review_controller.dart';

class WorkerProfileReview extends StatelessWidget {
  const WorkerProfileReview({
    super.key,
    required this.controller,
  });

  final EmployerReviewController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
    
      itemBuilder: (_, index) {
        final item = controller.allReview[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 18.h),
          child: CustomShadowContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(
                        50.r,
                      ),
                      child: Image.asset(
                        item.imageUrl,
                        height: 38.h,
                        width: 38.w,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      item.title,
                      style: getBodyTextStyle(
                        fontSize: sp(16),
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
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Appcolor.primaryColor,
                      ),
                      itemCount: 5,
                      itemSize: sp(20),
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
          ),
        );
      },
    );
  }
}
