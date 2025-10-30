import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_shadow_container.dart'
    show CustomShadowContainer;
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employee/profile/controller/employee_controllre.dart';
import 'package:hollyb1213/features/employee/profile/widgets/profile_upper_section.dart';
import 'package:hollyb1213/features/employee/profile/widgets/your_stats.dart';

class EmployeeProfileScreen extends StatelessWidget {
  final controller = Get.put(EmployeeProfileControllre());
  EmployeeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 63.h),
              ProfileUpperSection(),
              SizedBox(height: 30.h),
              Text(
                "Your Stats",
                style: getBodyTextStyle(
                  fontSize: sp(20),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),
              YourStats(controller: controller),
              SizedBox(height: 30.h),
              Text(
                "Settings",
                style: getBodyTextStyle(
                  fontSize: sp(20),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.only(bottom: 18.h),
                child: CustomShadowContainer(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        Iconpath.notification,
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

                            // Row(
                            //   children: [
                            //     ToggleButtons(
                            //       children: children,
                            //       isSelected: isSelected,
                            //     ),

                            //     Text(
                            //       item.subTitle,
                            //       style: getBodyTextStyle(
                            //         color: Appcolor.appTextSecondaryColor,
                            //       ),
                            //       textAlign: TextAlign.start,
                            //       overflow: TextOverflow.ellipsis,
                            //       maxLines: 2,
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),

                      Obx(
                        () => ToggleButtons(
                          borderRadius: BorderRadius.circular(8),
                          selectedColor: Colors.white,
                          fillColor: Appcolor.primaryColor.withValues(
                            alpha: .4,
                          ),
                          color: Colors.black,
                          constraints: BoxConstraints(
                            minHeight: 25.h,
                            minWidth: 40.w,
                          ),
                          isSelected: controller.isSelected,
                          onPressed: (index) => controller.toggle(index),
                          children: [
                            Text(
                              "Enable",
                              style: getBodyTextStyle(fontSize: sp(8)),
                            ),
                            Text(
                              "Disable",
                              style: getBodyTextStyle(fontSize: sp(8)),
                            ),
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
                            onTap: () {},
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

              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
