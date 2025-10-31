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
            "Select the dates and times for this job",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
          ),
          SizedBox(height: 20.h),

          /// Fields
          Column(
            children: List.generate(4, (index) {
              final fieldTitles = [
                "Start Date",
                "End Date",
                "Start Time",
                "End Time",
              ];
              final isDateField = index < 2;

              return Obx(
                () => Padding(
                  padding: EdgeInsets.only(bottom: 14.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title above field
                      Text(
                        fieldTitles[index] + (index == 1 ? " (Optional)" : ""),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 6.h),

                      // Input Field
                      TextField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: isDateField
                              ? (controller.selectedDates[index % 2].value !=
                                        null
                                    ? "${controller.selectedDates[index % 2].value!.day}/${controller.selectedDates[index % 2].value!.month}/${controller.selectedDates[index % 2].value!.year}"
                                    : "")
                              : (controller.selectedTimes[index % 2].value !=
                                        null
                                    ? controller.selectedTimes[index % 2].value!
                                          .format(context)
                                    : ""),
                        ),
                        onTap: () => isDateField
                            ? controller.pickDate(context, index % 2)
                            : controller.pickTime(context, index % 2),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            isDateField
                                ? Icons.calendar_today
                                : Icons.access_time,
                            size: 22.sp,
                          ),
                          hintText: isDateField
                              ? "DD/MM/YYYY"
                              : "HH:MM (e.g. 10:30 AM)",
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
