import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/widget/custom_shadow_container.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employer/profile_screen/profile/controller/employer_controllre.dart';

class YourStats extends StatelessWidget {
  const YourStats({
    super.key,
    required this.controller,
  });

  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 20.h,
          childAspectRatio: 1.3,
        ),
        itemCount: controller.statsList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = controller.statsList[index];

          return CustomShadowContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(item["iconImage"], height: 40.h, width: 40.w),
                SizedBox(height: 4.h),
                Text(
                  item["count"],
                  style: getBodyTextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  item["completedMsg"],
                  style: getBodyTextStyle(
                    color: Appcolor.appTextSecondaryColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
