import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employee/employee_applied_jobs/controller/employee_applied_jobs_controller.dart';
import 'package:readytowork/features/employee/employee_applied_jobs/screen/applied_jobs_screen.dart';
import 'package:readytowork/features/employee/home/controller/employe_home_controller.dart';
import 'package:readytowork/routes/app_route.dart';


class QuickActions extends StatelessWidget {
  const QuickActions({super.key, required this.controller});

  final EmployeHomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: getBodyTextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),

          /// --- Reactive Row of Quick Actions ---
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: controller.quickActions.map((action) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (action["title"] == "Available Jobs") {
                        Get.toNamed(AppRoute.employeeAvailablejobs);
                      } else if (action["title"] == "Applied Jobs") {
                        // Use lazyPut to create the controller only once.
                        Get.lazyPut(() => EmployeeAppliedJobsController());
                        Get.to(() => const AppliedJobsScreen());
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: (action["height"] as double).w,
                            width: (action["width"] as double).w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(6.w),
                              child: Image.asset(
                                action["icon"] as String,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            action["title"] as String,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            action["subtitle"] as String,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
