import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employee/bottom_navbar/jobs/controller/job_controller.dart';
import 'package:hollyb1213/features/employee/bottom_navbar/jobs/model/job_model.dart';

class JobScreen extends StatelessWidget {
  final JobController controller = Get.put(JobController());

  JobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          onChanged: (value) => controller.searchText.value = value,
          decoration: InputDecoration(
            hintText: 'Search jobs...',
            fillColor: Colors.grey[100],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildCategoryChips(),
          Expanded(
            child: Obx(() {
              final filtered = controller.jobs.where((job) {
                if (controller.selectedCategory.value != 'All' &&
                    job.category != controller.selectedCategory.value) {
                  return false;
                }
                if (controller.searchText.value.isNotEmpty &&
                    !job.title.toLowerCase().contains(
                      controller.searchText.value.toLowerCase(),
                    )) {
                  return false;
                }
                return true;
              }).toList();

              return ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (_, index) => _jobCard(filtered[index]),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    final categories = [
      'All',
      'Nearby',
      'Urgent',
      'High Pay',
      'Restaurant',
      'Delivery',
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 50.h,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder: (_, __) => SizedBox(width: 8),
          itemBuilder: (_, index) {
            final category = categories[index];
            return Obx(() {
              final selected = controller.selectedCategory.value == category;
              return GestureDetector(
                onTap: () => controller.selectedCategory.value = category,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? Appcolor.primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Appcolor.primaryColor.withValues(alpha: .6),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    category,
                    style: getTextStyle(
                      color: selected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget _jobCard(JobModel job) {
    final Map<String, Color> categoryColors = {
      'Nearby': Colors.green,
      'Urgent': Colors.redAccent,
      'High Pay': Colors.orange,
      'Restaurant': Colors.purple,
      'Delivery': Colors.blue,
      'All': Colors.grey,
    };

    return Card(
      color: Appcolor.backgroundcolor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                job.imageUrl,
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    job.title,
                    style: getTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: categoryColors[job.category] ?? Colors.grey,
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: Text(
                    job.category,
                    style: getTextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(Icons.location_on, size: 16.sp, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  job.location,
                  style: getTextStyle(color: Appcolor.appTextSecondaryColor),
                ),
                SizedBox(width: 12.w),
                Icon(Icons.attach_money, size: 16.sp, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  job.pay,
                  style: getTextStyle(color: Appcolor.appTextSecondaryColor),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () {
                // Handle Quick Apply action
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Appcolor.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Quick Apply',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
