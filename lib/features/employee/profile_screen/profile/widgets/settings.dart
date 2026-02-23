import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/common/constants/appcolor.dart';
import '../../../../../core/common/constants/iconpath.dart';
import '../../../../../core/common/constants/widget/custom_shadow_container.dart';
import '../../../../../core/common/style/global_text_style.dart';
import '../controller/employee_controllre.dart';

class Settings extends StatelessWidget {
  const Settings({super.key, required this.controller});

  final EmployeeProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 18.h),
          child: CustomShadowContainer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Iconpath.notificationProfile,
                  height: 40.h,
                  width: 40.w,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notifications",
                        style: getBodyTextStyle(
                          fontSize: sp(18),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => ToggleButtons(
                    borderRadius: BorderRadius.circular(8),
                    selectedColor: Colors.white,
                    fillColor: Appcolor.primaryColor.withValues(alpha: .4),
                    color: Colors.black,
                    constraints: BoxConstraints(
                      minHeight: 25.h,
                      minWidth: 40.w,
                    ),
                    isSelected: controller.isSelected,
                    onPressed: (index) => controller.toggle(index),
                    children: [
                      Text("Off", style: getBodyTextStyle(fontSize: sp(10))),
                      Text("On", style: getBodyTextStyle(fontSize: sp(10))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.settingsitems.length,
          itemBuilder: (_, index) {
            final item = controller.settingsitems[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 18.h),
              child: CustomShadowContainer(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(item.imageUrl, height: 40.h, width: 40.w),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: getBodyTextStyle(
                              fontSize: sp(18),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            item.subTitle,
                            style: getBodyTextStyle(
                              color: Appcolor.appTextSecondaryColor,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: item.ontap,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: sp(20),
                        color: Appcolor.appTextSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
