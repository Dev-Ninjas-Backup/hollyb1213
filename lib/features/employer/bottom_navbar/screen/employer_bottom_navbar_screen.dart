import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/iconpath.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employer/bottom_navbar/controller/employer_bottom_navbar_controller.dart';
import 'package:readytowork/features/employer/home/screen/employer_home_screen.dart';
import 'package:readytowork/features/employer/jobs/screen/employer_jobs_screen.dart';
import 'package:readytowork/features/message/screen/message_screen.dart';
import 'package:readytowork/features/employer/profile_screen/profile/screen/employer_profile_screen.dart';

class EmployerBottomNavbarScreen extends StatelessWidget {
  const EmployerBottomNavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployerBottomNavbarController controller = Get.put(
      EmployerBottomNavbarController(),
    );

    final List<Widget> pages = [
      EmployerHomeScreen(),
      EmployerJobsScreen(),
      MessageScreen(),
      EmployerProfileScreen(),
    ];

    final List<String> icons = [
      Iconpath.home,
      Iconpath.job,
      Iconpath.message,
      Iconpath.profile,
    ];

    final List<String> labels = ["Home", "Jobs", "Messages", "Profile"];

    return Obx(
      () => Scaffold(
        backgroundColor: Appcolor.backgroundcolor,
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: Material(
          elevation: 3,
          shadowColor: Colors.black.withValues(alpha: .08),
          color: Appcolor.backgroundcolor,
          child: Container(
            decoration: BoxDecoration(
              color: Appcolor.backgroundcolor,
              border: Border(
                top: BorderSide(
                  color: Colors.black.withValues(alpha: 0.05),
                  width: 0.8,
                ),
              ),
            ),
            padding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
              bottom: 46.h,
              top: 12.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(icons.length, (index) {
                bool isSelected = controller.currentIndex.value == index;
                return GestureDetector(
                  onTap: () => controller.changeIndex(index),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          icons[index],
                          width: 26.w,
                          height: 26.h,
                          color:
                              isSelected ? Appcolor.primaryColor : Colors.grey,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          labels[index],
                          style: getTextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Appcolor.primaryColor
                                : Colors.grey.withValues(alpha: .8),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
