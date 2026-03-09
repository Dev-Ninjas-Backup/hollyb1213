// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/create_post/controller/create_post_controller.dart';

class TimeSection extends StatelessWidget {
  const TimeSection({super.key, required this.controller});

  final CreatePostController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
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
            "Schedule",
            style: getBodyTextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "Select the date and times for this job",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
          ),
          SizedBox(height: 20.h),

          /// Job Date (Read-only during edit)
          Obx(
            () => _buildPickerField(
              context: context,
              title: "Job Date",
              icon: Icons.calendar_today,
              hintText: "YYYY-MM-DD",
              valueWidget: Text(
                controller.selectedJobDate.value != null
                    ? "${controller.selectedJobDate.value!.day}/${controller.selectedJobDate.value!.month}/${controller.selectedJobDate.value!.year}"
                    : "",
                style: TextStyle(fontSize: 14.sp),
              ),
              onTap: () => controller.pickJobDate(context),
              enabled: !controller.isEditMode.value,
            ),
          ),
          SizedBox(height: 14.h),

          /// Start Time
          _buildPickerField(
            context: context,
            title: "Start Time",
            icon: Icons.access_time,
            hintText: "HH:MM (e.g. 10:30 AM)",
            valueWidget: Obx(
              () => Text(
                controller.startTime.value != null
                    ? controller.startTime.value!.format(context)
                    : "",
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
            onTap: () => controller.pickStartTime(context),
          ),
          SizedBox(height: 14.h),

          /// End Time
          _buildPickerField(
            context: context,
            title: "End Time",
            icon: Icons.access_time,
            hintText: "HH:MM (e.g. 06:00 PM)",
            valueWidget: Obx(
              () => Text(
                controller.endTime.value != null
                    ? controller.endTime.value!.format(context)
                    : "",
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
            onTap: () => controller.pickEndTime(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPickerField({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String hintText,
    required Widget valueWidget,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
          ),
        ),
        SizedBox(height: 6.h),
        GestureDetector(
          onTap: enabled ? onTap : null,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: enabled ? Colors.grey[200] : Colors.grey[100],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(icon,
                    size: 22.sp,
                    color: enabled ? Colors.grey[700] : Colors.grey[500]),
                SizedBox(width: 10.w),
                Expanded(
                  child: enabled
                      ? valueWidget
                      : Opacity(
                          opacity: 0.6,
                          child: valueWidget,
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
