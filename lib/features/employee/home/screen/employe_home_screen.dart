import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/iconpath.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employee/employee_notification/screen/employee_notification_screen.dart';
import 'package:readytowork/features/employee/home/screen/schedule_card.dart';
import 'package:readytowork/features/employee/home/screen/schedule_model.dart';
import 'package:readytowork/features/employee/home/widgets/header_section_widget.dart';
import 'package:readytowork/features/employee/home/widgets/job_card_widget.dart';
import 'package:readytowork/features/employee/home/widgets/quick_actions_widget.dart';
import 'package:readytowork/routes/app_route.dart';
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
            HeaderSection(controller: controller),
            SizedBox(height: 20.h),
            QuickActions(controller: controller),
            SizedBox(height: 25.h),
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
                    children: controller.latestJobs.map<Widget>((job) {
                      return JobCard(
                        image: job.fileUrl ?? '',
                        title: job.title,
                        subtitle: job.companyName,
                        distance: job.location,
                        urgent: job.isUrgent,
                        payRate: "\$${job.amount}",
                        buttonText: "Apply Now",
                        onPressed: () {
                          Get.toNamed(
                            AppRoute.getjobDetailsScreen(),
                            arguments: job.id,
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming Schedule",
                    style: getBodyTextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Obx(() {
                    if (controller.isSchedulesLoading.value &&
                        controller.schedules.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.schedules.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("No upcoming schedule."),
                        ),
                      );
                    }

                    return Column(
                      children: controller.schedules.map((Schedule schedule) {
                        return ScheduleCard(schedule: schedule);
                      }).toList(),
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
}
