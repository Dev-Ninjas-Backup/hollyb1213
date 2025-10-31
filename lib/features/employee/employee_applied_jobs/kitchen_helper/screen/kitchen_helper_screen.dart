import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employee/employee_applied_jobs/kitchen_helper/controller/kitchen_helper_controller.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_back_button.dart';

class KitchenHelperScreen extends StatelessWidget {
  const KitchenHelperScreen({super.key});

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
                      "Kitchen Helper",
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
                      child: Image.asset(
                        Imagepath.image1,
                        width: double.infinity,
                        height: 154.h,
                        fit: BoxFit.cover,
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
                                Text("City Diner"),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.attach_money, size: 16),
                                SizedBox(width: 4),
                                Text("\$18/hour"),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 16),
                                SizedBox(width: 4),
                                Text("8:00 AM - 4:00 PM"),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16),
                                SizedBox(width: 4),
                                Text("Today"),
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
                          value: controller.isCheckedIn.value ? 0.6 : 0.0,
                          minHeight: 10.h,
                          backgroundColor: Colors.grey[300],
                          color: Appcolor.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text("4h 30m remaining"),
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
                      "Assist in kitchen operations including food prep, dishwashing, and maintaining cleanliness. Must follow safety protocols and work efficiently in a team environment.",
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
                        children: [
                          Text("• Basic food handling skills"),
                          Text("• Punctual and responsible"),
                          Text(
                            "• Comfortable working in a fast-paced environment",
                          ),
                        ],
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
                                  : controller.checkIn,
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
                              onPressed:
                                  controller.isCheckedIn.value &&
                                      !controller.isCheckedOut.value
                                  ? controller.checkOut
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
                              onPressed:
                                  controller.isCheckedOut.value &&
                                      !controller.isCompleted.value
                                  ? controller.markCompleted
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
                              Text("8 hours"),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Estimated pay"),
                              Text(
                                "\$144.00",
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
