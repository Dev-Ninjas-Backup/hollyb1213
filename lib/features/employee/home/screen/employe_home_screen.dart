import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employee/employee_notification/screen/employee_notification_screen.dart';
import 'package:hollyb1213/features/employee/home/widgets/header_section_widget.dart';
import 'package:hollyb1213/features/employee/home/widgets/job_card_widget.dart';
import 'package:hollyb1213/features/employee/home/widgets/quick_actions_widget.dart';
import 'package:hollyb1213/routes/app_route.dart';
import '../controller/employe_home_controller.dart';

class EmployeHomeScreen extends StatelessWidget {
  const EmployeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmployeHomeController>();

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Appcolor.primaryColor,
        toolbarHeight: 55.h,
        titleSpacing: 0,
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 35.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Appcolor.backgroundcolor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      Iconpath.search,
                      height: 20.h,
                      width: 20.w,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 14.sp),
                        decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: getBodyTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Get.to(EmployeeNotificationScreen());
              },
              icon: Image.asset(
                Iconpath.notification,
                width: 35.w,
                height: 35.h,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Header Section ---
            HeaderSection(controller: controller),
            SizedBox(height: 20.h),

            // --- Quick Actions ---
            QuickActions(controller: controller),
            SizedBox(height: 25.h),

            // --- Nearby Jobs ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Jobs",
                    style: getBodyTextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "View All",
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),

            // --- Job Cards with Separate Buttons ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Obx(
                () {
                  if (controller.isLoading.value &&
                      controller.latestJobs.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.latestJobs.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("No latest jobs available."),
                      ),
                    );
                  }

                  return Column(
                    children: controller.latestJobs.map((job) {
                      // NOTE: Assuming the structure of the job object from the API.
                      // You may need to adjust these keys to match your API response.
                      return JobCard(
                        image: job['file'] ?? '',
                        title: job['title'] ?? 'No Title',
                        subtitle: job['company_name'] ?? 'No Company',
                        distance: job['location'] ?? 'No Location',
                        urgent: job['is_urgent'] ?? false,
                        payRate: "\$${job['amount'] ?? '0'}",
                        buttonText: "Quick Apply",
                        onPressed: () {
                          final jobId = job['id'];
                          if (jobId != null) {
                            Get.toNamed(AppRoute.getjobDetailsScreen(),
                                arguments: jobId);
                          } else {
                            Get.snackbar(
                                'Error', 'Unable to open job details.');
                          }
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),

            // --- Schedule Boxes (End Section) ---
            // --- Schedule Boxes (End Section) ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                children: [
                  // Dummy data for scheduled jobs. In a real app, this would come from the controller.
                  ...[
                    {
                      'title': "Morning Shift - Cafe Helper",
                      'subtitle': "Sunrise Cafe",
                      'time': "8:00 AM - 12:00 PM",
                      'amount': "\$85",
                      'statusText': "Now", // Default status
                      'statusBackground': const Color(0xFFDFF7DF),
                      'statusColor': Colors.green,
                    },
                    {
                      'title': "Afternoon Shift - Barista",
                      'subtitle': "Sunset Cafe",
                      'time': "1:00 PM - 5:00 PM",
                      'amount': "\$90",
                      'statusText': "Pending",
                      'statusBackground': Colors.yellow.shade100,
                      'statusColor': Colors.yellow[800]!,
                    },
                    {
                      'title': "Evening Shift - Kitchen Assistant",
                      'subtitle': "The Grand Restaurant",
                      'time': "6:00 PM - 10:00 PM",
                      'amount': "\$110",
                      'statusText': "Upcoming",
                      'statusBackground': Colors.blue.shade100,
                      'statusColor': Colors.blue[800]!,
                    },
                  ].map((job) {
                    return buildScheduleBox(
                      title: job['title'] as String,
                      subtitle: job['subtitle'] as String,
                      time: job['time'] as String,
                      amount: job['amount'] as String,
                      statusText: job['statusText'] as String,
                      statusBackground: job['statusBackground'] as Color,
                      statusColor: job['statusColor'] as Color,
                    );
                  }),
                ],
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // --- buildScheduleBox Widget ---
  Widget buildScheduleBox({
    required String title,
    required String subtitle,
    required String time,
    required String amount,
    String statusText = "Now",
    Color statusBackground = const Color(0xFFDFF7DF),
    Color statusColor = Colors.green,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: statusBackground,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                  SizedBox(width: 4.w),
                  Text(
                    time,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.attach_money, size: 14, color: Colors.grey[600]),
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
