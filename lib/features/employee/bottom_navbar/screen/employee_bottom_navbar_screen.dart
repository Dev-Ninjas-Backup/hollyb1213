import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/iconpath.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employee/bottom_navbar/controller/employee_bottom_navbar_controller.dart';
import 'package:readytowork/features/employee/home/controller/employe_home_controller.dart';
import 'package:readytowork/features/employee/home/screen/employe_home_screen.dart';
import 'package:readytowork/features/employee/jobs/controller/employee_jobs_controller.dart';
import 'package:readytowork/features/employee/jobs/screen/employee_jobs_screen.dart';
import 'package:readytowork/features/employee/profile_screen/profile/screen/employee_profile_screen.dart';
import 'package:readytowork/features/employee/profile_screen/profile/widgets/employee_profile_controller.dart';
import 'package:readytowork/features/message/controller/message_controller.dart';
import 'package:readytowork/features/message/screen/message_screen.dart';


class EmployeeBottomNavbarScreen extends StatelessWidget {
  const EmployeeBottomNavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure MessageController is created once and persists with the navbar.
    // This keeps the socket connection alive across tab switches.
    Get.put(MessageController());

    final EmployeeBottomNavbarController controller =
        Get.find<EmployeeBottomNavbarController>();

    final List<Widget> pages = [
      EmployeHomeScreen(),
      const JobScreen(),
      const MessageScreen(), // Use const since the screen is now stateless and simple
      EmployeeProfileScreen(),
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
                  onTap: () {
                    // Only trigger actions if the index is changing
                    if (controller.currentIndex.value != index) {
                      controller.changeIndex(index);
                      // Refresh data when switching to a tab
                      if (index == 0) {
                        Get.find<EmployeHomeController>().getLatestJobs();
                      } else if (index == 1) {
                        Get.find<EmployeeJobsController>().getJobs();
                      } else if (index == 2) {
                        // The controller is guaranteed to be registered.
                        // Fetch conversations without a loading spinner for a smoother UX.
                        Get.find<MessageController>()
                            .fetchConversations(showLoading: false);
                      } else if (index == 3) {
                        Get.put(EmployeeProfileController()).fetchUserProfile();
                      }
                    }
                  },
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
