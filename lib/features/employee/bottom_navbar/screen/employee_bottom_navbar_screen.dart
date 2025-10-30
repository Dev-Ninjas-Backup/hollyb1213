import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employee/bottom_navbar/controller/employee_bottom_navbar_controller.dart';
import 'package:hollyb1213/features/employee/home/screen/employe_home_screen.dart';

class EmployeeBottomNavbarScreen extends StatelessWidget {
  const EmployeeBottomNavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeBottomNavbarController controller = Get.put(
      EmployeeBottomNavbarController(),
    );

    final List<Widget> pages = [
      EmployeHomeScreen(),
      // EmployeHomeScreen(),
      //  EmployeHomeScreen(),
      // EmployeHomeScreen(),
    ];

    final List<String> icons = [
      Iconpath.home,
      Iconpath.job,
      Iconpath.message,
      Iconpath.profile,
    ];

    final List<String> labels = ["Home", "Messages", "Orders", "Profile"];

    return Obx(
      () => Scaffold(
        backgroundColor: Appcolor.backgroundcolor,
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      icons[index],
                      width: 26.w,
                      height: 26.h,
                      color: isSelected ? Appcolor.primaryColor : Colors.grey,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      labels[index],
                      style: getTextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Appcolor.primaryColor : Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
