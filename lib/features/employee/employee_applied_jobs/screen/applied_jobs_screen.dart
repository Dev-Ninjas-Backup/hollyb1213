import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_back_button.dart';
import '../controller/applied_jobs_controller.dart';

class AppliedJobsScreen extends StatelessWidget {
  const AppliedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppliedJobsController());
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
            // --- Tab Bar ---
            buildTabBar(controller),
            // --- Job List ---
            Expanded(
              child: Obx(() {
                final isActive = controller.selectedTab.value == 0;
                final jobs = isActive
                    ? controller.activeJobs
                    : controller.completedJobs;
                return ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) =>
                      buildJobCard(jobs[index], isActive),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // --- Tab Bar ---
  Widget buildTabBar(AppliedJobsController controller) {
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
    AppliedJobsController controller,
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
  Widget buildJobCard(Map<String, dynamic> job, bool isActive) {
    Color statusColor = Color(job['statusColor']);
    return GestureDetector(
      onTap: job['onTap'],
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
              child: Image.asset(
                job['image'],
                width: double.infinity,
                height: 154.h,
                fit: BoxFit.cover,
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
                          job['title'],
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
                          job['status'],
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
                    job['company'],
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
                        job['distance'],
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      SizedBox(width: 10.w),
                      Icon(Icons.attach_money, size: 16.sp, color: Colors.grey),
                      Text(
                        job['rate'],
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
                        job['time'],
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                  if (isActive && job['progressText'] != '') ...[
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
                          job['progressText'],
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
