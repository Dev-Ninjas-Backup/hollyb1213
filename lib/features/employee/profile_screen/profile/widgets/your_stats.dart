import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_shadow_container.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/widgets/employee_profile_controller.dart';

class YourStats extends StatelessWidget {
  const YourStats({
    super.key,
    required this.controller,
  });

  final EmployeeProfileController controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
                  fontSize: sp(20),
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
    );
  }
}
