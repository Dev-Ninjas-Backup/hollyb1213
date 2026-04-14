import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/features/employer/profile_screen/worker_profile/model/employee_profile_model.dart';
import '../../../../../core/common/constants/widget/custom_shadow_container.dart';
import '../../../../../core/common/style/global_text_style.dart';

class WorkerProfileReview extends StatelessWidget {
  final EmployeeProfileData profile;

  const WorkerProfileReview({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    // Show only first 3 reviews
    final reviewsToShow = profile.receivedReviews.length > 3
        ? profile.receivedReviews.sublist(0, 3)
        : profile.receivedReviews;

    if (reviewsToShow.isEmpty) {
      return Center(
        child: Text(
          'No reviews yet',
          style: getBodyTextStyle(color: Appcolor.appTextSecondaryColor),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: reviewsToShow.length,
      itemBuilder: (_, index) {
        final review = reviewsToShow[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 18.h),
          child: CustomShadowContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 38.h,
                      width: 38.w,
                      decoration: BoxDecoration(
                        color: Appcolor.primaryColor.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Icon(
                        Icons.person,
                        color: Appcolor.primaryColor,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.job.companyName,
                            style: getBodyTextStyle(
                              fontSize: sp(16),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            review.job.title,
                            style: getBodyTextStyle(
                              fontSize: sp(14),
                              color: Appcolor.appTextSecondaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    RatingBarIndicator(
                      unratedColor: Appcolor.primaryColor.withValues(
                        alpha: .5,
                      ),
                      rating: review.rating.toDouble(),
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Appcolor.primaryColor,
                      ),
                      itemCount: 5,
                      itemSize: sp(16),
                      direction: Axis.horizontal,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      review.rating.toString(),
                      style: getBodyTextStyle(
                        color: Appcolor.appTextSecondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  review.comment,
                  style: getBodyTextStyle(),
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
