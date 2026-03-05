import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/completed_job_details/controller/completed_job_details_controller.dart';

class CompletedJobDetailsScreen extends StatelessWidget {
  final String jobId;

  const CompletedJobDetailsScreen({
    super.key,
    required this.jobId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CompletedJobDetailsController(jobId: jobId),
      tag: jobId,
    );
    final reviewController = TextEditingController();

    return WillPopScope(
      onWillPop: () async {
        Get.delete<CompletedJobDetailsController>(tag: jobId);
        return true;
      },
      child: Scaffold(
        backgroundColor: Appcolor.backgroundcolor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Appcolor.backgroundcolor,
          elevation: 0,
          title: Text(
            'Completed Job Details',
            style: getTextStyle(
              fontWeight: FontWeight.w600,
              color: Appcolor.primaryColor,
              fontSize: 18,
            ),
          ),
          centerTitle: false,
          foregroundColor: Appcolor.primaryColor,
        ),
        body: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: Appcolor.primaryColor,
                  ),
                )
              : (controller.job.value == null
                  ? Center(
                      child: Text('Failed to load job details'),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --- Job Image ---
                          Container(
                            width: double.infinity,
                            height: 200.h,
                            color: Colors.grey[300],
                            child: controller.job.value?.fileUrl != null
                                ? Image.network(
                                    controller.job.value!.fileUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: Icon(
                                          Icons.image_not_supported,
                                          size: 64.sp,
                                          color: Colors.grey[600],
                                        ),
                                      );
                                    },
                                  )
                                : Icon(
                                    Icons.image_not_supported,
                                    size: 64.sp,
                                    color: Colors.grey[600],
                                  ),
                          ),

                          // --- Job Title & Badge Section ---
                          Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Job Title & Rate
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.job.value?.title ?? '',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12.w,
                                              vertical: 4.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.blue[50],
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                              border: Border.all(
                                                color: Colors.blue[200]!,
                                              ),
                                            ),
                                            child: Text(
                                              controller
                                                      .job.value?.companyName ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue[700],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '\$${controller.job.value?.amount}/hr',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Appcolor.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 16.h),

                                // Location
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 20,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        controller.job.value?.location ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 12.h),

                                // Dates & Time
                                Container(
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 18,
                                                  color: Colors.grey[600],
                                                ),
                                                SizedBox(width: 8.w),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Start Date:',
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                      ),
                                                      Text(
                                                        controller.startDate,
                                                        style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Expanded(
                                          //   child: Row(
                                          //     children: [
                                          //       Icon(
                                          //         Icons.calendar_today,
                                          //         size: 18,
                                          //         color: Colors.grey[600],
                                          //       ),
                                          //       SizedBox(width: 8.w),
                                          //       Expanded(
                                          //         child: Column(
                                          //           crossAxisAlignment:
                                          //               CrossAxisAlignment
                                          //                   .start,
                                          //           children: [
                                          //             Text(
                                          //               'End Date:',
                                          //               style: TextStyle(
                                          //                 fontSize: 12.sp,
                                          //                 color:
                                          //                     Colors.grey[600],
                                          //               ),
                                          //             ),
                                          //             Text(
                                          //               controller.endDate,
                                          //               style: TextStyle(
                                          //                 fontSize: 13.sp,
                                          //                 fontWeight:
                                          //                     FontWeight.w600,
                                          //                 color: Colors.black,
                                          //               ),
                                          //             ),
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            size: 18,
                                            color: Colors.grey[600],
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            controller.timeRange,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 24.h),

                                // Job Summary Section
                                Text(
                                  'Job Summary',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),

                                SizedBox(height: 12.h),

                                GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  childAspectRatio: 1.3,
                                  crossAxisSpacing: 12.w,
                                  mainAxisSpacing: 12.h,
                                  children: [
                                    _buildSummaryCard('Job Title',
                                        controller.job.value?.title ?? ''),
                                    _buildSummaryCard(
                                        'Work Place Home',
                                        controller.job.value?.companyName ??
                                            ''),
                                    _buildSummaryCard(
                                        'Job Type',
                                        controller.job.value?.jobCategory ??
                                            ''),
                                    _buildSummaryCard('Rate',
                                        '\$${controller.job.value?.amount}/hour'),
                                    _buildSummaryCard('Completed',
                                        controller.formattedJobDate),
                                    _buildSummaryCard('Total Hours Worked',
                                        controller.totalHoursWorked),
                                  ],
                                ),

                                SizedBox(height: 24.h),

                                // Total Earnings Section
                                Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100.w,
                                        height: 100.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFE8F1FF),
                                          border: Border.all(
                                            color: Appcolor.primaryColor
                                                .withOpacity(0.2),
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.attach_money,
                                                size: 32.sp,
                                                color: Appcolor.primaryColor,
                                              ),
                                              Text(
                                                'Total Earnings',
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                controller.totalEarnings,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Appcolor.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 32.h),

                                // Rate this Worker Section
                                Text(
                                  'Rate this Worker',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),

                                SizedBox(height: 16.h),

                                // Star Rating
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      5,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          controller.setRating(index + 1);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: Icon(
                                            index <
                                                    controller
                                                        .selectedRating.value
                                                ? Icons.star
                                                : Icons.star_border,
                                            size: 32.sp,
                                            color: Colors.amber[600],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 8.h),

                                Center(
                                  child: Text(
                                    'Tap to rate your experience',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20.h),

                                // Review Text Field
                                Text(
                                  'Write your review (optional)',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),

                                SizedBox(height: 10.h),

                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEF4FF),
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: reviewController,
                                    maxLines: 4,
                                    maxLength: 500,
                                    onChanged: (value) {
                                      controller.reviewText.value = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText:
                                          'Share your experience with this worker...',
                                      hintStyle: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey[500],
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(14.w),
                                      counterStyle: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20.h),

                                // Submit Review Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Appcolor.primaryColor,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                    ),
                                    onPressed: () {
                                      controller.submitReview();
                                    },
                                    child: Text(
                                      'Submit Review',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String label, String value) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[200]!,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
