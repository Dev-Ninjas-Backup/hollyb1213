// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/create_post/controller/create_post_controller.dart';
import 'package:hollyb1213/features/employer/create_post/widgets/drop_down_field_widget.dart';
import 'package:hollyb1213/features/employer/create_post/widgets/text_field_widget.dart';

class JobInformation extends StatelessWidget {
  const JobInformation({super.key, required this.controller});

  final CreatePostController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Appcolor.backgroundcolor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Job Information",
            style: getBodyTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "Provide the main details about the job position",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
          ),
          SizedBox(height: 20.h),

          TextFielld(
            title: "Job Title",
            controller: controller.jobTitleController,
            hintText: "Restaurant Helper",
          ),

          /// Job Category
          TextFielld(
            title: "Job Category",
            controller: controller.jobCategoryController,
            hintText: "Helper",
          ),

          /// Job Type Dropdown
          DropDownField(controller: controller),

          SizedBox(height: 16.h),
          Text(
            "Job Description",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              "We’re looking for a dedicated and hardworking Restaurant Helper to assist in daily kitchen and dining operations. Your responsibilities will include helping chefs.",
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            ),
          ),

          SizedBox(height: 16.h),
          Text(
            "Skills Required",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              "We’re looking for a dedicated and hardworking Restaurant Helper to assist in daily kitchen and dining operations. Your responsibilities will include helping chefs.",
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            ),
          ),

          /// Urgent Switch
          SizedBox(height: 20.h),
          Obx(
            () => Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mark this job as Urgent?",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Enable push urgent",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: controller.isUrgent.value,
                    onChanged: controller.toggleUrgent,
                    activeColor: Appcolor.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
