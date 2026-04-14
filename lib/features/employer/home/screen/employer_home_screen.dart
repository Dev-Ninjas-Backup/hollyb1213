import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/iconpath.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employer/create_post/screen/create_post_screen.dart';
import 'package:readytowork/features/employer/home/controller/employer_home_controller.dart';
import 'package:readytowork/features/employer/home/notification/screen/notification_screen.dart';
import 'package:readytowork/features/employer/home/widgets/employer_header_section.dart';
import 'package:readytowork/features/employer/home/widgets/employer_job_card.dart';
import 'package:readytowork/features/employer/home/widgets/employer_quick_actions.dart';
import 'package:readytowork/features/employer/completed_job_details/screen/completed_job_details_screen.dart';
import 'package:readytowork/routes/app_route.dart';

class EmployerHomeScreen extends StatelessWidget {
  const EmployerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmployerHomeController());

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Appcolor.primaryColor,
        toolbarHeight: 55.h,
        titleSpacing: 0,
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 35.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Appcolor.backgroundcolor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      Iconpath.search,
                      height: 20.h,
                      width: 20.w,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 14.sp),
                        decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: getBodyTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Get.to(() => NotificationScreen());
              },
              icon: Image.asset(
                Iconpath.notification,
                width: 35.w,
                height: 35.h,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EmployerHeaderSection(controller: controller),
            SizedBox(height: 20.h),

            EmployerQuickActions(controller: controller),
            SizedBox(height: 25.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCategoryChip(controller, 'Active'),
                    SizedBox(width: 10.w),
                    _buildCategoryChip(controller, 'Completed'),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // --- Filtered Job Cards ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Obx(
                () => Column(
                  children: List.generate(controller.filteredJobs.length, (
                    index,
                  ) {
                    final job = controller.filteredJobs[index];
                    final isCompleted =
                        controller.selectedCategory.value == 'Completed';
                    final isFavourite =
                        controller.favouriteJobIds.contains(job.id).obs;

                    // Extract rating from review object if exists
                    double? rating;
                    if (job.review is Map &&
                        (job.review as Map).containsKey('rating')) {
                      rating =
                          ((job.review as Map)['rating'] as num?)?.toDouble();
                    }

                    // Check if employee is already favorited (for completed jobs)
                    if (isCompleted && job.assignedEmployeeId != null) {
                      controller
                          .checkIfEmployeeFavorite(job.assignedEmployeeId!)
                          .then((isFav) {
                        isFavourite.value = isFav;
                      });
                    }

                    return EmployerJobCard(
                      image:
                          job.imageUrl ?? 'assets/images/job_placeholder.png',
                      title: job.title,
                      subtitle: job.location,
                      distance: job.location,
                      urgent: job.isUrgent,
                      status: job.status,
                      showEdit: !isCompleted,
                      showFavourite: isCompleted,
                      isFavourite: isFavourite,
                      applicants: job.applicants,
                      amount: job.amount,
                      rating: rating,
                      assignedEmployeeId: job.assignedEmployeeId,
                      onFavouriteTap: () => controller.toggleFavourite(index),
                      onViewDetails: () {
                        if (isCompleted) {
                          Get.to(
                            () => CompletedJobDetailsScreen(jobId: job.id),
                          );
                        } else {
                          Get.toNamed(
                            AppRoute.getEmployerJobDetailsScreen(),
                            arguments: job.id,
                          );
                        }
                      },
                      onEdit: () {
                        Get.to(
                          () => const CreatePostScreen(),
                          arguments: job.id,
                        );
                      },
                      onAddWorkerFavourite: () async {
                        // Add employee as favorite
                        if (job.assignedEmployeeId != null) {
                          await controller.addEmployeeAsFavorite(
                            job.assignedEmployeeId!,
                          );
                          isFavourite.value = true;
                        }
                      },
                    );
                  }),
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // --- Category Chip Builder ---
  Widget _buildCategoryChip(
    EmployerHomeController controller,
    String category,
  ) {
    final isSelected = controller.selectedCategory.value == category;
    return GestureDetector(
      onTap: () => controller.setCategory(category),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Appcolor.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Appcolor.primaryColor),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Appcolor.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
