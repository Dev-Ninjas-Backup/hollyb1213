import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_back_button.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_button.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import '../controller/job_details_controller.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobDetailsController());

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Appcolor.primaryColor),
                SizedBox(height: 20.h),
                Text("Loading job details .....",
                    style: getBodyTextStyle(color: Colors.grey.shade600)),
              ],
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomBackButton(),
                    ),
                    Center(
                      child: Text(
                        "Job Details",
                        style: getTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Appcolor.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: controller.imageUrl != null
                    ? Image.network(
                        controller.imageUrl!,
                        width: double.infinity,
                        height: 200.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: double.infinity,
                          height: 200.h,
                          color: Colors.grey.shade200,
                          child: Icon(Icons.broken_image_outlined,
                              color: Colors.grey.shade400, size: 48.r),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: 200.h,
                        color: Colors.grey.shade200,
                        child: Icon(Icons.broken_image_outlined,
                            color: Colors.grey.shade400, size: 48.r),
                      ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: controller.title,
                              style: getBodyTextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              )),
                          TextSpan(
                              text: '  ${controller.payRate}',
                              style: getTextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.h),
                    Text(
                      controller.company,
                      style: getBodyTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    SizedBox(height: 14.h),

                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 18.sp, color: Colors.grey),
                        SizedBox(width: 6.w),
                        Expanded(child: Text(controller.location)),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    // --- Date ---
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 16.sp, color: Colors.grey),
                        SizedBox(width: 6.w),
                        Text('Start: ${controller.startDate}'),
                        SizedBox(width: 12.w),
                        Text('End: ${controller.endDate}'),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 16.sp, color: Colors.grey),
                        SizedBox(width: 6.w),
                        Text(controller.workTime),
                      ],
                    ),

                    SizedBox(height: 14.h),

                    // --- About Job ---
                    Text(
                      'About this job',
                      style: getBodyTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(controller.about),

                    SizedBox(height: 12.h),

                    // --- Responsibilities ---
                    if (controller.responsibilities.isNotEmpty) ...[
                      Text(
                        'Responsibilities',
                        style: getBodyTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ...controller.responsibilities.map(
                        (item) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("• ", style: TextStyle(fontSize: 16.sp)),
                            Expanded(child: Text(item)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],

                    Text(
                      'Requirements',
                      style: getBodyTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    ...controller.requirements.map(
                      (req) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("• ", style: TextStyle(fontSize: 16.sp)),
                          Expanded(child: Text(req)),
                        ],
                      ),
                    ),

                    SizedBox(height: 12.h),

                    Text(
                      'Additional details',
                      style: getBodyTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ...controller.additionalDetails.map(
                      (req) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("• ", style: TextStyle(fontSize: 16.sp)),
                          Expanded(child: Text(req)),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // --- Apply Button ---
                    Obx(() => CustomButton(
                          buttonText: controller.isApplying.value
                              ? "Applying..."
                              : "Apply Now",
                          onTap: controller.isApplying.value
                              ? null
                              : () => _showApplyDialog(context, controller),
                        )),
                    SizedBox(height: 70.h),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showApplyDialog(BuildContext context, JobDetailsController controller) {
    final TextEditingController noteController = TextEditingController();
    Get.dialog(
      Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Apply for Job",
                style:
                    getTextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16.h),
              Text(
                "Cover Note",
                style: getBodyTextStyle(
                    fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: noteController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Briefly describe why you are a good fit...",
                  hintStyle: getBodyTextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text("Cancel", style: TextStyle(color: Colors.grey)),
                  ),
                  SizedBox(width: 8.w),
                  ElevatedButton(
                    onPressed: () {
                      if (noteController.text.trim().isNotEmpty) {
                        Get.back(); // Close dialog
                        controller.applyJob(noteController.text.trim());
                      } else {
                        Get.snackbar("Required", "Please enter a cover note",
                            snackPosition: SnackPosition.TOP);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: getTextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
