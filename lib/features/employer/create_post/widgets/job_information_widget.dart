// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employer/create_post/controller/create_post_controller.dart';
import 'package:readytowork/features/employer/create_post/widgets/dynamic_list_field_widget.dart';
import 'package:readytowork/features/employer/create_post/widgets/text_field_widget.dart';


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

          /// Job Title
          TextFielld(
            title: "Job Title",
            controller: controller.jobTitleController,
            hintText: "Restaurant Helper",
          ),

          /// Company Name
          TextFielld(
            title: "Company Name",
            controller: controller.companyNameController,
            hintText: "Enter company name",
          ),

          /// Job Category Dropdown
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Job Category",
                  style: getBodyTextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Obx(
                    () => DropdownButton<String>(
                      value: controller.selectedCategory.value,
                      hint: Text("Select Job Category"),
                      isExpanded: true,
                      underline: SizedBox(),
                      items: controller.jobCategories
                          .map(
                            (cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(controller.categoryDisplayName(cat)),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedCategory.value = value;
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Job Description
          SizedBox(height: 8.h),
          Text(
            "Job Description",
            style: getBodyTextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: controller.jobDescriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText:
                    "Describe the job responsibilities and what you're looking for...",
                hintStyle: TextStyle(color: Colors.grey[600]),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 14.h,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          /// Job Responsibilities (dynamic list)
          SizedBox(height: 20.h),
          DynamicListField(
            title: "Job Responsibilities",
            controllers: controller.responsibilities,
            hintText: "e.g. Assist in daily kitchen operations",
            onAdd: controller.addResponsibility,
            onRemove: controller.removeResponsibility,
          ),

          /// Requirements (dynamic list)
          SizedBox(height: 16.h),
          DynamicListField(
            title: "Requirements",
            controllers: controller.requirements,
            hintText: "e.g. Must have food safety certificate",
            onAdd: controller.addRequirement,
            onRemove: controller.removeRequirement,
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
