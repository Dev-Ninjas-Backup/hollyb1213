import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/common/constants/appcolor.dart';
import '../../../../../core/common/constants/widget/custom_shadow_container.dart';
import '../../../../../core/common/style/global_text_style.dart';
import 'custom_skill_container.dart';

class WorkerProfileSkills extends StatelessWidget {
  const WorkerProfileSkills({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 14.w,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: CustomSkillContainer(text: "Cleaning")),
            Expanded(child: CustomSkillContainer(text: "waiter")),
          ],
        ),
    
        SizedBox(height: 12.h),
    
        Row(
          spacing: 14.w,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomSkillContainer(text: "Kitchen Assistant"),
            ),
            Expanded(
              child: CustomSkillContainer(text: "Kitchen Assistant"),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        CustomSkillContainer(text: "Kitchen Helper"),
        SizedBox(height: 20.h),
        CustomShadowContainer(
          width: double.infinity,
          padding: EdgeInsets.all(10.h),
    
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Job History",
                style: getBodyTextStyle(
                  fontSize: sp(18),
                  fontWeight: FontWeight.w500,
                  color: Appcolor.appTextColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Last Job: Restaurant Helper - 3 Months",
                style: getBodyTextStyle(),
              ),
              SizedBox(height: 4.h),
    
              Text("Completed Job: 40", style: getBodyTextStyle()),
            ],
          ),
        ),
      ],
    );
  }
}
