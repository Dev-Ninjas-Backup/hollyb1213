import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/features/employee/profile_screen/profile/widgets/employee_profile_controller.dart';
import 'package:readytowork/features/employer/profile_screen/profile/widgets/profile_upper_section.dart';

class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeProfileController controller =
        Get.put(EmployeeProfileController());

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.fetchUserProfile(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.userProfile.value == null) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.userProfile.value == null) {
                return const Center(child: Text('Could not load profile.'));
              }
              return ProfileUpperSection(
                  userProfile: controller.userProfile.value!);
            }),
          ),
        ),
      ),
    );
  }
}
