import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/home/controller/employer_home_controller.dart';
import 'package:hollyb1213/features/employer/home/widgets/employer_job_card.dart';
import 'package:hollyb1213/routes/app_route.dart';

class EmployerJobsScreen extends StatelessWidget {
  const EmployerJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmployerHomeController());

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      appBar: AppBar(
        title: Text(
          "My Jobs",
          style: getTextStyle(
            fontWeight: FontWeight.w600,
            color: Appcolor.primaryColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Appcolor.backgroundcolor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCategoryChip(controller, 'Active'),
                  SizedBox(width: 12.w),
                  _buildCategoryChip(controller, 'Completed'),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            /// --- Job Cards (Dynamic) ---
            Obx(
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
                    showEdit: !isCompleted,
                    showFavourite: isCompleted,
                    isFavourite: job['isFavourite'], // <-- pass RxBool directly
                    onFavouriteTap: () => controller.toggleFavourite(index),
                    onViewDetails: () {
                      Get.toNamed(AppRoute.getjobDetailsScreen());
                    },
                    onEdit: () {
                      // handle edit
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// --- Category Chip Widget ---
  Widget _buildCategoryChip(
    EmployerHomeController controller,
    String category,
  ) {
    final isSelected = controller.selectedCategory.value == category;
    return GestureDetector(
      onTap: () => controller.setCategory(category),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 8.h),
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
