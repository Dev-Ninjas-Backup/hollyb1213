import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employee/home/controller/employe_home_controller.dart';


class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.controller});

  final EmployeHomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Appcolor.primaryColor,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              controller.headerTitle.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Appcolor.backgroundcolor,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              controller.headerSubtitle.value,
              textAlign: TextAlign.center,
              style: getBodyTextStyle(fontSize: 12.sp, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
