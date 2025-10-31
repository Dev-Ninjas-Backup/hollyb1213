import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/create_post/screen/create_post_screen.dart';
import 'package:hollyb1213/features/employer/home/controller/employer_home_controller.dart';

class EmployerHeaderSection extends StatelessWidget {
  const EmployerHeaderSection({super.key, required this.controller});

  final EmployerHomeController controller;

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
            SizedBox(height: 12),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                height: 32.h,
                width: 120.w,
                decoration: BoxDecoration(
                  color: Appcolor.backgroundcolor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    '+ Post New Job',
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Appcolor.appBodyColor,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Get.to(CreatePostScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
