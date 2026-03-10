import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_app_bar.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/profile_screen/review/screen/employer_review_page.dart';
import 'package:hollyb1213/features/employer/profile_screen/worker_profile/controller/employer_worker_profile_controller.dart';
import 'package:hollyb1213/features/employer/profile_screen/worker_profile/widgets/employer__worker_profile_upper_section.dart';
import 'package:hollyb1213/features/employer/profile_screen/worker_profile/widgets/information.dart';
import 'package:hollyb1213/routes/app_route.dart';
import '../widgets/message_call_button.dart';
import '../widgets/worker_profile_review.dart';
import '../widgets/worker_profile_skills.dart';

class EmployerWorkerProfile extends StatelessWidget {
  final String employeeId;
  final controller = Get.put(EmployerWorkerProfileController());

  EmployerWorkerProfile({super.key, required this.employeeId}) {
    controller.fetchEmployeeProfile(employeeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: Appcolor.primaryColor,
                ),
              )
            : controller.employeeProfile.value == null
                ? Center(
                    child: Text('Failed to load profile'),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomAppBar(
                              title: "Profile", iconUrl: Iconpath.backIcon),
                          EmployerWorkerProfileUpperSection(
                            profile: controller.employeeProfile.value!,
                          ),
                          SizedBox(height: 12.h),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    Appcolor.primaryColor.withValues(alpha: .2),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.verified_user_outlined,
                                      size: sp(20),
                                      color: Appcolor.primaryColor,
                                    ),
                                    SizedBox(width: 12.w),
                                    Text(
                                      "Verified Worker",
                                      style: getTextStyle(
                                        fontSize: sp(14),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Information(
                            profile: controller.employeeProfile.value!,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "Skills",
                            style: getBodyTextStyle(
                              fontSize: sp(18),
                              fontWeight: FontWeight.w500,
                              color: Appcolor.appTextColor,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          WorkerProfileSkills(
                            profile: controller.employeeProfile.value!,
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Reviews",
                                style: getBodyTextStyle(
                                  fontSize: sp(18),
                                  fontWeight: FontWeight.w500,
                                  color: Appcolor.appTextColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => EmployerReviewPage(
                                        employeeId: controller
                                            .employeeProfile.value!.id,
                                      ));
                                },
                                child: Text(
                                  "View All",
                                  style: getBodyTextStyle(
                                    fontSize: sp(12),
                                    fontWeight: FontWeight.w500,
                                    color: Appcolor.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          WorkerProfileReview(
                            profile: controller.employeeProfile.value!,
                          ),
                          MessageAndCallButton(),
                          SizedBox(height: 70.h),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
