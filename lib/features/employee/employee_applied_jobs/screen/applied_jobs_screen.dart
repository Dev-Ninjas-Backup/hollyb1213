import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_back_button.dart';
import 'package:hollyb1213/features/employee/employee_applied_jobs/kitchen_helper/screen/kitchen_helper_screen.dart';
import 'package:hollyb1213/features/employee/employee_applied_jobs/model/job_model.dart';
import '../controller/employee_applied_jobs_controller.dart';

class AppliedJobsScreen extends StatelessWidget {
  const AppliedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmployeeAppliedJobsController>();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
        child: Column(
          children: [
            // --- Header ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(),
                  ),
                  Center(
                    child: Text(
                      "Applied Jobs",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w600,
                        color: Appcolor.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            buildTabBar(controller),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.appliedJobsList.isEmpty) {
                  return Center(
                    child:
                        CircularProgressIndicator(color: Appcolor.primaryColor),
                  );
                }

                final isActive = controller.selectedTab.value == 0;
                // The controller should flatten the API response so that `jobs` is a list
                // of maps, where each map contains both application details and job details.
                final jobs =
                    isActive ? controller.activeJobs : controller.completedJobs;

                if (jobs.isEmpty) {
                  return Center(
                    child: Text(
                        "No ${isActive ? 'active' : 'completed'} jobs found."),
                  );
                }

                return ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) =>
                      buildJobCard(jobs[index], isActive, controller),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabBar(EmployeeAppliedJobsController controller) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTabButton(
            controller,
            0,
            'Active (${controller.activeJobs.length})',
          ),
          SizedBox(width: 8.w),
          buildTabButton(
            controller,
            1,
            'Completed (${controller.completedJobs.length})',
          ),
        ],
      ),
    );
  }

  Widget buildTabButton(
    EmployeeAppliedJobsController controller,
    int index,
    String text,
  ) {
    bool isSelected = controller.selectedTab.value == index;
    return GestureDetector(
      onTap: () => controller.selectedTab.value = index,
      child: Container(
        width: 140.w,
        height: 36.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Appcolor.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Appcolor.primaryColor, width: 2),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: isSelected ? Colors.white : Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // --- Job Card ---
  Widget buildJobCard(Map<String, dynamic> job, bool isActive,
      EmployeeAppliedJobsController controller) {
    // Map API status to color.
    Color getStatusColor(String? status) {
      switch (status?.toLowerCase()) {
        case 'in-progress':
          return const Color(0xFF2ECC71);
        case 'confirmed':
          return const Color(0xFF3498DB);
        case 'applied':
          return const Color(0xFFF1C40F);
        case 'completed':
          return const Color(0xFF27AE60);
        default:
          return Colors.grey;
      }
    }

    final String jobStatus = job['status']?.toString().toLowerCase() ?? '';
    final String applicationStatus =
        job['application_status']?.toString().toLowerCase() ?? '';

    final String displayStatus;
    final Color statusColor;

    if (jobStatus == 'completed') {
      displayStatus = 'Completed';
      statusColor = getStatusColor('completed');
    } else {
      if (applicationStatus == 'in-progress') {
        displayStatus = 'In Progress';
      } else if (applicationStatus.isNotEmpty) {
        displayStatus =
            applicationStatus[0].toUpperCase() + applicationStatus.substring(1);
      } else {
        displayStatus = 'Unknown';
      }
      statusColor = getStatusColor(applicationStatus);
    }

    return GestureDetector(
      onTap: () {
        if (isActive) {
          final jobModel = JobModel.fromMap(job);
          Get.to(() => KitchenHelperScreen(job: jobModel));
        } else {
          // Handle completed jobs navigation if needed
          Get.snackbar('Completed Job', 'This job is already completed.');
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.grey.shade100,
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: (job['file']?['url'] != null)
                  ? Image.network(
                      job['file']['url'],
                      width: double.infinity,
                      height: 154.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        height: 154.h,
                        color: Colors.grey.shade200,
                        child: Icon(Icons.broken_image_outlined,
                            color: Colors.grey.shade400, size: 48),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: 154.h,
                      color: Colors.grey.shade200,
                      child: Icon(Icons.broken_image_outlined,
                          color: Colors.grey.shade400, size: 48),
                    ),
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          job['title'] ?? 'No Title',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          displayStatus,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    job['company_name'] ?? 'No Company',
                    style: TextStyle(fontSize: 13.sp, color: Colors.black54),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16.sp,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        job['location'] ?? 'No Location',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      SizedBox(width: 10.w),
                      Icon(Icons.attach_money, size: 16.sp, color: Colors.grey),
                      Text(
                        job['amount']?.toString() ?? 'N/A', // Use 'amount'
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 16.sp,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${job['start_time'] ?? 'N/A'} - ${job['end_time'] ?? 'N/A'}',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                  if (isActive && applicationStatus == 'in-progress') ...[
                    SizedBox(height: 8.h),
                    Divider(height: 1, color: Colors.grey.shade300),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Shift Progress",
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          job['progress_text'] ?? '', // Not in API response
                          style: TextStyle(
                            color: Appcolor.primaryColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.r),
                      child: LinearProgressIndicator(
                        minHeight: 10.h,
                        backgroundColor: Colors.grey[300],
                        color: Appcolor.primaryColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
