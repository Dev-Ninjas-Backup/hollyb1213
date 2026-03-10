import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employee/employee_applied_jobs/kitchen_helper/controller/kitchen_helper_controller.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_back_button.dart';
import 'package:hollyb1213/features/employee/employee_applied_jobs/model/job_model.dart';

class KitchenHelperScreen extends StatelessWidget {
  final JobModel job;
  const KitchenHelperScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KitchenHelperController());
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(),
                  ),
                  Center(
                    child: Text(
                      job.title,
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

            // --- Body ---
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: job.image.startsWith('http')
                          ? Image.network(
                              job.image,
                              width: double.infinity,
                              height: 154.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.grey[200],
                                child: Icon(Icons.image,
                                    size: 50, color: Colors.grey[400]),
                              ),
                            )
                          : Center(
                              child: Icon(Icons.work,
                                  size: 100, color: Colors.grey[400]),
                            ),
                    ),
                    SizedBox(height: 16.h),

                    // Job Info
                    Card(
                      color: Colors.white, // <-- Added white background
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 16),
                                SizedBox(width: 4),
                                Text(job.company),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.attach_money, size: 16),
                                SizedBox(width: 4),
                                Text(job.rate),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 16),
                                SizedBox(width: 4),
                                Text(job.time),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16),
                                SizedBox(width: 4),
                                Text("Today"), // This seems to be static
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Shift Progress
                    Text(
                      "Shift Progress",
                      style: getBodyTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Obx(
                      () => ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: LinearProgressIndicator(
                          value: controller.currentProgress.value,
                          minHeight: 10.h,
                          backgroundColor: Colors.grey[300],
                          color: Appcolor.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(job.progressText),
                    SizedBox(height: 16.h),

                    // Job Description
                    Text(
                      "Job Description",
                      style: getBodyTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      job.jobDescription,
                    ),
                    SizedBox(height: 16.h),

                    // Requirements
                    Text(
                      "Requirements",
                      style: getBodyTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: job.requirements
                                ?.map((req) => Text("• $req"))
                                .toList() ??
                            [],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Shift Actions
                    Text(
                      "Shift Actions",
                      style: getBodyTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                      () => Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 44.h,
                            child: ElevatedButton(
                              onPressed: controller.isCheckedIn.value
                                  ? null
                                  : () => controller.checkIn(job.id.toString()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Appcolor.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text(
                                "Check In",
                                style: getBodyTextStyle(
                                  color: Appcolor.appBodyColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            width: double.infinity,
                            height: 44.h,
                            child: ElevatedButton(
                              onPressed: controller.isCheckedIn.value &&
                                      !controller.isCheckedOut.value
                                  ? () => controller.checkOut(job.id.toString())
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text(
                                "Check Out",
                                style: getBodyTextStyle(
                                  color: Appcolor.appTextColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            width: double.infinity,
                            height: 44.h,
                            child: ElevatedButton(
                              onPressed: controller.isCheckedOut.value &&
                                      !controller.isCompleted.value
                                  ? () => controller
                                      .markCompleted(job.id.toString())
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text(
                                "Mark as Completed",
                                style: getBodyTextStyle(
                                  color: Appcolor.appTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.grey.withOpacity(
                              0.2,
                            ), // subtle shadow
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Summary",
                            style: getBodyTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Shift Hours"),
                              Obx(() => Text(
                                    controller.totalShiftHours.value,
                                    style: getBodyTextStyle(
                                        fontWeight: FontWeight.w600),
                                  )),
                              Text(
                                  "8 hours"), // This should probably come from the job model
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Estimated pay"),
                              Obx(() => Text(
                                    controller.estimatedPay.value,
                                    style:
                                        getBodyTextStyle(color: Colors.green),
                                  )),
                              Text(
                                "\$144.00", // This should be calculated or from the model
                                style: getBodyTextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
