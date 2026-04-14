import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/features/employer/create_post/screen/create_post_screen.dart';
import 'package:readytowork/features/employer/job_details/controller/job_details_controller.dart';


class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobDetailsController());

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Appcolor.primaryColor),
      //     onPressed: () => Get.back(),
      //   ),
      //   title: Text(
      //     "Job Details",
      //     style: TextStyle(
      //       color: Appcolor.primaryColor,
      //       fontSize: 18.sp,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Appcolor.primaryColor),
                onPressed: () => Get.back(),
              ),
              title: Text(
                "Job Details",
                style: TextStyle(
                  color: Appcolor.primaryColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            Obx(
              () {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Appcolor.primaryColor,
                    ),
                  );
                }

                final job = controller.jobDetails.value;
                if (job == null) {
                  return Center(
                    child: Text('Job details not found'),
                  );
                }

                final imageUrl = job['file'] is Map
                    ? job['file']['url']
                    : (job['file'] ?? '');

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Job Image ---
                      _buildJobImage(imageUrl),

                      // --- Main Content ---
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- Title & Pay ---
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        job['title'] ?? 'Untitled Job',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        job['company_name'] ?? 'Company',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '\$${job['amount'] ?? '0'}/hr',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Appcolor.primaryColor,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16.h),

                            // --- Status Badge & Details Row ---
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDFF7DF),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    controller.getDisplayStatus(
                                        job['status'] ?? 'open'),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                if (job['is_urgent'] == true)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFE5E5),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      'Urgent',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red[700],
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            SizedBox(height: 16.h),

                            // --- Job Details Row ---
                            Row(
                              children: [
                                _buildDetailItem(
                                  Icons.location_on_outlined,
                                  job['location'] ?? 'Location TBD',
                                ),
                                SizedBox(width: 16.w),
                                _buildDetailItem(
                                  Icons.calendar_today_outlined,
                                  _formatDate(job['job_date']),
                                ),
                              ],
                            ),

                            SizedBox(height: 12.h),

                            // --- Time Details ---
                            Row(
                              children: [
                                _buildDetailItem(
                                  Icons.access_time_outlined,
                                  '${job['start_time'] ?? 'TBD'} - ${job['end_time'] ?? 'TBD'}',
                                ),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // --- Job Description Section ---
                            Text(
                              'Job Description',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              job['description'] ?? 'No description provided',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[700],
                                height: 1.5,
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // --- Your Responsibilities ---
                            Text(
                              'Your Responsibilities',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            _buildBulletList(job['job_responsibilities'] ?? []),

                            SizedBox(height: 24.h),

                            // --- Requirements ---
                            Text(
                              'Requirements',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            _buildBulletList(job['requirements'] ?? []),

                            SizedBox(height: 24.h),

                            // --- Additional Details ---
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Additional Details',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  _buildDetailRow('Job Category:',
                                      _formatJobCategory(job['job_category'])),
                                  SizedBox(height: 8.h),
                                ],
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // --- Actions Buttons ---
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      // Navigate to edit job screen with job ID
                                      Get.to(
                                        () => const CreatePostScreen(),
                                        arguments: job['id'],
                                      );
                                    },
                                    icon: Icon(Icons.edit, size: 18.sp),
                                    label: Text('Edit Job'),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color: Appcolor.primaryColor),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      // Handle close post
                                    },
                                    icon: Icon(Icons.close, size: 18.sp),
                                    label: Text('Close Post'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Appcolor.primaryColor,
                                      foregroundColor: Colors.white,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Build job image
  Widget _buildJobImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(16.r),
        bottomRight: Radius.circular(16.r),
      ),
      child: Container(
        width: double.infinity,
        height: 200.h,
        color: Colors.grey[300],
        child: imageUrl.isEmpty || imageUrl.contains('null')
            ? Icon(
                Icons.image_not_supported,
                size: 64.sp,
                color: Colors.grey[600],
              )
            : Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.image_not_supported,
                  size: 64.sp,
                  color: Colors.grey[600],
                ),
              ),
      ),
    );
  }

  /// Build detail item with icon
  Widget _buildDetailItem(IconData icon, String text) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: Colors.grey),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[700],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Build bullet list from array
  Widget _buildBulletList(List<dynamic> items) {
    if (items.isEmpty) {
      return Text(
        'No items listed',
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.grey[600],
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map<Widget>((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '• ',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  item.toString(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Build detail row
  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  /// Format date
  String _formatDate(dynamic date) {
    if (date == null) return 'TBD';
    try {
      final dateTime = DateTime.parse(date.toString());
      return '${dateTime.day} ${_monthName(dateTime.month)} ${dateTime.year}';
    } catch (e) {
      return 'TBD';
    }
  }

  /// Format job category from enum to readable text
  String _formatJobCategory(dynamic category) {
    if (category == null || category.toString().isEmpty) return 'N/A';
    return category
        .toString()
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  /// Get month name
  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
