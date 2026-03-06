import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/jobs/controller/employer_jobs_controller.dart';
import 'package:hollyb1213/features/employer/home/widgets/employer_job_card.dart';
import 'package:hollyb1213/features/employer/completed_job_details/screen/completed_job_details_screen.dart';
import 'package:hollyb1213/routes/app_route.dart';

class EmployerJobsScreen extends StatelessWidget {
  const EmployerJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmployerJobsController());

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
      body: GetBuilder<EmployerJobsController>(
        init: controller,
        builder: (ctrl) {
          return ctrl.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: Appcolor.primaryColor,
                  ),
                )
              : SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildCategoryChip(ctrl, 'Open', 'open'),
                            SizedBox(width: 12.w),
                            _buildCategoryChip(ctrl, 'Assigned', 'assigned'),
                            SizedBox(width: 12.w),
                            _buildCategoryChip(ctrl, 'Completed', 'completed'),
                            SizedBox(width: 12.w),
                            _buildCategoryChip(ctrl, 'Cancelled', 'cancelled'),
                            SizedBox(width: 12.w),
                            _buildCategoryChip(ctrl, 'Closed', 'closed'),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),

                      /// --- Urgent Filter Toggle ---
                      Obx(
                        () => Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => ctrl.toggleUrgentFilter(),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: !ctrl.isUrgentFilter.value
                                        ? Appcolor.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                        color: Appcolor.primaryColor),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'NOt Urgent',
                                      style: TextStyle(
                                        color: !ctrl.isUrgentFilter.value
                                            ? Colors.white
                                            : Appcolor.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => ctrl.toggleUrgentFilter(),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: ctrl.isUrgentFilter.value
                                        ? Appcolor.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                        color: Appcolor.primaryColor),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Urgent',
                                      style: TextStyle(
                                        color: ctrl.isUrgentFilter.value
                                            ? Colors.white
                                            : Appcolor.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),

                      /// --- Job Cards (Dynamic) ---
                      if (ctrl.filteredJobs.isEmpty)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.w),
                            child: Column(
                              children: [
                                Icon(Icons.work_off,
                                    size: 64.sp, color: Colors.grey[400]),
                                SizedBox(height: 16.h),
                                Text(
                                  'No jobs found',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Column(
                          children: List.generate(
                            ctrl.filteredJobs.length,
                            (index) {
                              final job = ctrl.filteredJobs[index];
                              final formattedJob = ctrl.formatJobForUI(job);
                              // Extract rating from review object if exists
                              double? rating;
                              if (job['review'] is Map &&
                                  (job['review'] as Map)
                                      .containsKey('rating')) {
                                rating =
                                    ((job['review'] as Map)['rating'] as num?)
                                        ?.toDouble();
                              }

                              // Check if employee is already favorited (for completed jobs)
                              if (formattedJob['status'] == 'completed' &&
                                  job['assigned_employee_id'] != null) {
                                ctrl
                                    .checkIfEmployeeFavorite(
                                        job['assigned_employee_id'])
                                    .then((isFav) {
                                  formattedJob['isFavourite']!.value = isFav;
                                });
                              }

                              return EmployerJobCard(
                                image: formattedJob['image'],
                                title: formattedJob['title'],
                                subtitle: formattedJob['subtitle'],
                                distance: formattedJob['distance'],
                                urgent: formattedJob['urgent'],
                                status: formattedJob['status'],
                                showEdit: formattedJob['status'] == 'open',
                                showFavourite:
                                    formattedJob['status'] == 'completed',
                                isFavourite: formattedJob['isFavourite'],
                                applicants: formattedJob['applicants'] ?? 0,
                                amount: formattedJob['amount'],
                                rating: rating,
                                assignedEmployeeId: job['assigned_employee_id'],
                                onFavouriteTap: () =>
                                    ctrl.toggleFavourite(job['id']),
                                onViewDetails: () {
                                  if (formattedJob['status'] == 'completed') {
                                    Get.to(
                                      CompletedJobDetailsScreen(
                                        jobId: job['id'],
                                      ),
                                    );
                                  } else {
                                    Get.toNamed(
                                      AppRoute.getEmployerJobDetailsScreen(),
                                      arguments: job['id'],
                                    );
                                  }
                                },
                                onEdit: () {
                                  // handle edit
                                },
                                onAddWorkerFavourite: () async {
                                  // Add employee as favorite
                                  if (job['assigned_employee_id'] != null) {
                                    await ctrl.addEmployeeAsFavorite(
                                      job['assigned_employee_id'],
                                    );
                                    formattedJob['isFavourite']?.value = true;
                                  }
                                },
                              );
                            },
                          ),
                        ),

                      // Load More Button (pagination)
                      if (ctrl.filteredJobs.isNotEmpty &&
                          ctrl.currentPage.value < ctrl.totalPages.value)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: ElevatedButton(
                            onPressed: ctrl.isLoadingMore.value
                                ? null
                                : ctrl.loadMoreJobs,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolor.primaryColor,
                              minimumSize: Size(double.infinity, 48.h),
                            ),
                            child: ctrl.isLoadingMore.value
                                ? SizedBox(
                                    height: 24.h,
                                    width: 24.h,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : Text(
                                    'Load More',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  /// --- Category Chip Widget ---
  Widget _buildCategoryChip(
    EmployerJobsController controller,
    String displayName,
    String status,
  ) {
    return Obx(
      () {
        final isSelected = controller.selectedCategory.value == status;
        return GestureDetector(
          onTap: () => controller.setCategory(status),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? Appcolor.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Appcolor.primaryColor),
            ),
            child: Text(
              displayName,
              style: TextStyle(
                color: isSelected ? Colors.white : Appcolor.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
        );
      },
    );
  }
}
