// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/applicants/controller/view_applicants_controller.dart';
import 'package:hollyb1213/features/employer/applicants/model/job_applicant_model.dart';
import 'package:hollyb1213/features/employer/profile_screen/worker_profile/screen/employer_worker_profile.dart';

class ViewApplicantsScreen extends StatelessWidget {
  const ViewApplicantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ViewApplicantsController());

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundcolor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
        ),
        centerTitle: true,
        title: Text(
          "Applicants",
          style: getBodyTextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  SizedBox(width: 14.w),
                  Icon(Icons.search, color: Colors.grey, size: 22.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        controller.searchQuery.value = value;
                      },
                      style: TextStyle(fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: "Search applicants by name or Job...",
                        hintStyle: getBodyTextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  SizedBox(width: 14.w),
                ],
              ),
            ),
          ),

          // Job Expandable List
          Expanded(
            child: Obx(
              () {
                if (controller.isLoadingJobs.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Appcolor.primaryColor,
                    ),
                  );
                }

                final filteredJobs = controller.getFilteredJobs();
                if (filteredJobs.isEmpty) {
                  return Center(
                    child: Text(
                      'No jobs found',
                      style: getBodyTextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  itemCount: filteredJobs.length + 1,
                  itemBuilder: (context, index) {
                    // Load more button at the end
                    if (index == filteredJobs.length) {
                      if (controller.currentPage.value >=
                          controller.totalPages.value) {
                        return SizedBox(height: 20.h);
                      }
                      return Obx(
                        () => controller.isLoadingMoreJobs.value
                            ? Padding(
                                padding: EdgeInsets.all(16.w),
                                child: CircularProgressIndicator(
                                  color: Appcolor.primaryColor,
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.all(16.w),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: controller.loadMoreJobs,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Appcolor.primaryColor,
                                    ),
                                    child: Text(
                                      'Load More',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      );
                    }

                    final job = filteredJobs[index];
                    final jobId = job.id;

                    return Obx(
                      () {
                        final isExpanded =
                            controller.expandedJobIds.contains(jobId);
                        final applicants =
                            controller.getApplicantsForJob(jobId);
                        final isLoadingApplicants =
                            controller.loadingApplicantsFor.contains(jobId);

                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.r),
                              border: isExpanded
                                  ? Border.all(
                                      color: Appcolor.primaryColor
                                          .withOpacity(0.3),
                                      width: 1.2,
                                    )
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Job Header (tap to expand/collapse)
                                InkWell(
                                  onTap: () =>
                                      controller.toggleJobExpansion(jobId),
                                  borderRadius: BorderRadius.circular(14.r),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14.w,
                                      vertical: 14.h,
                                    ),
                                    child: Row(
                                      children: [
                                        // Job Image or Icon
                                        Container(
                                          height: 44.w,
                                          width: 44.w,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          child: _buildJobImage(job),
                                        ),
                                        SizedBox(width: 12.w),
                                        // Title & count
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                job.title,
                                                style: getBodyTextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(height: 2.h),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.people_outline,
                                                    size: 16.sp,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  Text(
                                                    "${job.count.jobApplications} Applicant${job.count.jobApplications != 1 ? 's' : ''}",
                                                    style: getBodyTextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Expand/collapse arrow
                                        Icon(
                                          isExpanded
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          size: 26.sp,
                                          color: Colors.grey.shade600,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Applicant Cards (when expanded)
                                if (isExpanded)
                                  if (isLoadingApplicants)
                                    Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: CircularProgressIndicator(
                                        color: Appcolor.primaryColor,
                                      ),
                                    )
                                  else if (applicants.isEmpty)
                                    Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: Text(
                                        'No pending applicants for this job',
                                        style: getBodyTextStyle(fontSize: 14),
                                      ),
                                    )
                                  else
                                    Column(
                                      children: applicants.map((applicant) {
                                        return _buildApplicantCard(
                                            applicant, controller, jobId);
                                      }).toList(),
                                    ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobImage(JobApplicantModel job) {
    final fileUrl = job.file?.url;

    if (fileUrl != null && fileUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.network(
          fileUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.work_outline,
              size: 22.sp,
              color: Colors.grey.shade700,
            );
          },
        ),
      );
    }

    return Icon(
      Icons.work_outline,
      size: 22.sp,
      color: Colors.grey.shade700,
    );
  }

  Widget _buildApplicantCard(
    Map<String, dynamic> applicant,
    ViewApplicantsController controller,
    String jobId,
  ) {
    final employee = applicant['employee'] as Map<String, dynamic>?;
    final user = employee?['user'] as Map<String, dynamic>?;
    final profilePhotoUrl = employee?['profile_photo_url'] as String? ?? '';
    final fullName = user?['full_name'] as String? ?? 'Unknown User';
    final experienceYears = employee?['experience_years'] ?? 0;
    final rating = employee?['rating'] as num? ?? 0;
    final totalJobs = employee?['total_jobs'] ?? 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              CircleAvatar(
                radius: 28.r,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: profilePhotoUrl.isNotEmpty
                    ? NetworkImage(profilePhotoUrl)
                    : null,
                child: profilePhotoUrl.isEmpty
                    ? Icon(Icons.person, size: 28.sp, color: Colors.grey)
                    : null,
              ),
              SizedBox(width: 12.w),

              // Info Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      fullName,
                      style: getBodyTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Experience
                    Text(
                      "$experienceYears years experience",
                      style: getBodyTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 4.h),

                    // Total Jobs
                    Text(
                      "Completed $totalJobs job${totalJobs != 1 ? 's' : ''}",
                      style: getBodyTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // Rating Row
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          "Rating $rating/5",
                          style: getBodyTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),

                    // View Profile
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Appcolor.primaryColor,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => EmployerWorkerProfile(
                                employeeId: employee?['id']?.toString() ?? ''));
                          },
                          child: Text(
                            "View Profile",
                            style: getBodyTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Appcolor.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Chat Icon
              GestureDetector(
                onTap: () {
                  // TODO: handle chat tap
                },
                child: Container(
                  height: 36.w,
                  width: 36.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline,
                    size: 18.sp,
                    color: Appcolor.primaryColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Accept / Reject Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    final applicationId = applicant['id'] as String? ?? '';
                    controller.acceptApplicant(applicationId, jobId: jobId);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Appcolor.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                  ),
                  child: Text(
                    "Accept",
                    style: getBodyTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Appcolor.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    final applicationId = applicant['id'] as String? ?? '';
                    controller.rejectApplicant(applicationId, jobId: jobId);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                  ),
                  child: Text(
                    "Reject",
                    style: getBodyTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
