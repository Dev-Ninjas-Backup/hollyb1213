import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/home/controller/employer_home_controller.dart';
import 'package:hollyb1213/features/employer/home/notification/screen/notification_screen.dart';
import 'package:hollyb1213/features/employer/home/widgets/employer_header_section.dart';
import 'package:hollyb1213/features/employer/home/widgets/employer_job_card.dart';
import 'package:hollyb1213/features/employer/home/widgets/employer_quick_actions.dart';
import 'package:hollyb1213/routes/app_route.dart';

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
                Get.to(NotificationScreen());
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
                    return EmployerJobCard(
                      image: job['image'],
                      title: job['title'],
                      subtitle: job['subtitle'],
                      distance: job['distance'],
                      urgent: job['urgent'],
                      status: job['status'] ?? 'open',
                      showEdit: !isCompleted,
                      showFavourite: isCompleted,
                      isFavourite:
                          job['isFavourite'], // <-- pass RxBool directly
                      onFavouriteTap: () => controller.toggleFavourite(index),
                      onViewDetails: () {
                        Get.toNamed(
                          AppRoute.getEmployerJobDetailsScreen(),
                          arguments: job['id'],
                        );
                      },
                      onEdit: () {
                        // handle edit
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
