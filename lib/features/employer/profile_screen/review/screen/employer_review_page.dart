import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/iconpath.dart';
import 'package:readytowork/core/common/constants/widget/custom_app_bar.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employer/profile_screen/review/controller/all_reviews_controller.dart';


class EmployerReviewPage extends StatelessWidget {
  final String employeeId;
  final controller = Get.put(AllReviewsController());

  EmployerReviewPage({super.key, required this.employeeId}) {
    controller.setEmployeeId(employeeId);
    controller.fetchAllReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: Appcolor.primaryColor,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(
                          title: "Reviews", iconUrl: Iconpath.backIcon),
                      SizedBox(height: 12.h),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${controller.getAverageRating().toStringAsFixed(1)}",
                              style: getBodyTextStyle(
                                fontSize: sp(30),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            RatingBarIndicator(
                              unratedColor:
                                  Appcolor.primaryColor.withValues(alpha: .5),
                              rating: controller.getAverageRating(),
                              itemBuilder: (context, index) => Icon(Icons.star,
                                  color: Appcolor.primaryColor),
                              itemCount: 5,
                              itemSize: sp(20),
                              direction: Axis.horizontal,
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "Based on ${controller.paginationInfo.value?.totalReviews ?? 0} reviews",
                              style: getBodyTextStyle(
                                color: Appcolor.appTextSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      _buildRatingDistribution(),
                      SizedBox(height: 20.h),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.reviews.length,
                        itemBuilder: (_, index) {
                          final review = controller.reviews[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 25.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 38.h,
                                      width: 38.w,
                                      decoration: BoxDecoration(
                                        color: Appcolor.primaryColor
                                            .withValues(alpha: .2),
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Appcolor.primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              color: Appcolor
                                                  .appTextSecondaryColor,
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
                                      unratedColor: Appcolor.primaryColor
                                          .withValues(alpha: .5),
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
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildRatingDistribution() {
    final ratingCounts = controller.getRatingCounts();
    final totalReviews = controller.reviews.length;

    return Column(
      children: [
        _buildRatingRow(
          "Excellent",
          ratingCounts['5'] ?? 0,
          totalReviews,
          Colors.green,
        ),
        SizedBox(height: 12.h),
        _buildRatingRow(
          "Good",
          ratingCounts['4'] ?? 0,
          totalReviews,
          Color(0xFFAFCC00),
        ),
        SizedBox(height: 12.h),
        _buildRatingRow(
          "Average",
          ratingCounts['3'] ?? 0,
          totalReviews,
          Color(0xFFFFA500),
        ),
        SizedBox(height: 12.h),
        _buildRatingRow(
          "Poor",
          ratingCounts['1'] ?? 0,
          totalReviews,
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildRatingRow(
    String label,
    int count,
    int total,
    Color color,
  ) {
    final percentage = total > 0 ? count / total : 0.0;

    return Row(
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            label,
            style: getBodyTextStyle(fontSize: sp(14)),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 8.h,
              backgroundColor: Colors.grey[300]!,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        SizedBox(
          width: 30.w,
          child: Text(
            count.toString(),
            style: getBodyTextStyle(fontSize: sp(14)),
          ),
        ),
      ],
    );
  }
}
