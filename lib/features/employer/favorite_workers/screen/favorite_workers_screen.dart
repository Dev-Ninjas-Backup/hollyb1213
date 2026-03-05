import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/favorite_workers/controller/favorite_workers_controller.dart';
import 'package:hollyb1213/features/employer/favorite_workers/model/favorite_employees_model.dart';
import 'package:hollyb1213/features/employer/profile_screen/worker_profile/screen/employer_worker_profile.dart';

class FavoriteWorkersScreen extends StatelessWidget {
  FavoriteWorkersScreen({super.key});

  final FavoriteWorkersController controller =
      Get.put(FavoriteWorkersController());
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Appcolor.primaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Favorite Workers",
          style: TextStyle(
            color: Appcolor.primaryColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            // --- Search Bar ---
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.grey[100]!,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  controller.searchEmployees(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  hintStyle: getBodyTextStyle(
                    fontSize: 14,
                    color: Colors.grey[400]!,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[400]!,
                    size: 20.sp,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 30.w,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // --- Worker List ---
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Appcolor.primaryColor,
                        ),
                      )
                    : controller.filteredEmployees.isEmpty
                        ? Center(
                            child: Text(
                              'No favorite workers yet',
                              style: getBodyTextStyle(
                                fontSize: 16,
                                color: Colors.grey[600]!,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: controller.filteredEmployees.length + 1,
                            itemBuilder: (context, index) {
                              // Check if we need to load more
                              if (index ==
                                  controller.filteredEmployees.length) {
                                if (controller.currentPage.value <
                                    controller.totalPages.value) {
                                  return Obx(
                                    () => Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.h),
                                      child: controller.isLoadingMore.value
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                color: Appcolor.primaryColor,
                                              ),
                                            )
                                          : Center(
                                              child: ElevatedButton(
                                                onPressed: () =>
                                                    controller.loadMore(),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Appcolor.primaryColor,
                                                ),
                                                child: Text(
                                                  'Load More',
                                                  style: getTextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  );
                                }
                                return SizedBox.shrink();
                              }

                              final employee =
                                  controller.filteredEmployees[index];
                              return _buildWorkerCard(employee, controller);
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildWorkerCard(
    FavoriteEmployee favorite, FavoriteWorkersController ctrl) {
  final employee = favorite.employee;
  return Container(
    margin: EdgeInsets.only(bottom: 20.h),
    padding: EdgeInsets.all(14.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.grey[200]!),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Profile Section ---
        Row(
          children: [
            // --- Profile Image ---
            ClipRRect(
              borderRadius: BorderRadius.circular(40.r),
              child: employee.profilePhotoUrl != null
                  ? Image.network(
                      employee.profilePhotoUrl!,
                      width: 66.w,
                      height: 66.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderImage();
                      },
                    )
                  : _buildPlaceholderImage(),
            ),
            SizedBox(width: 14.w),

            // --- Info Column ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        employee.fullName,
                        style: getTextStyle(
                          fontSize: sp(16),
                          fontWeight: FontWeight.w600,
                          color: Appcolor.appTextColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => ctrl.removeFavorite(employee.id),
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.grey[600]!,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  // --- Rating ---
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Appcolor.primaryColor,
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${employee.rating.toStringAsFixed(1)}/5',
                        style: getTextStyle(
                          fontSize: sp(12),
                          fontWeight: FontWeight.w600,
                          color: Appcolor.appTextColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),

                  // --- Total Jobs ---
                  Text(
                    'Total Jobs: ${employee.totalJobs}',
                    style: getBodyTextStyle(
                      fontSize: 12,
                      color: Colors.grey[700]!,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),

                  // --- Total Reviews ---
                  Text(
                    'Reviews: ${employee.totalReviews}',
                    style: getBodyTextStyle(
                      fontSize: 12,
                      color: Colors.grey[600]!,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),

        // --- View Profile Button ---
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFDDE9FF),
              foregroundColor: Appcolor.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              elevation: 0,
            ),
            onPressed: () {
              Get.to(EmployerWorkerProfile());
            },
            child: Text(
              'View Profile',
              style: getTextStyle(
                fontSize: sp(14),
                fontWeight: FontWeight.w600,
                color: Appcolor.primaryColor,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPlaceholderImage() {
  return Container(
    width: 66.w,
    height: 66.w,
    decoration: BoxDecoration(
      color: Colors.grey[300]!,
      shape: BoxShape.circle,
    ),
    child: Icon(
      Icons.person,
      color: Colors.grey[600]!,
      size: 30.sp,
    ),
  );
}
