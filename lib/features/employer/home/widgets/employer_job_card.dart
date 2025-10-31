import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';

class EmployerJobCard extends StatelessWidget {
  const EmployerJobCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.distance,
    required this.urgent,
    this.showEdit = true,
    this.showFavourite = false,
    this.isFavourite,
    required this.onViewDetails,
    this.onEdit,
    this.onFavouriteTap,
  });

  final String image;
  final String title;
  final String subtitle;
  final String distance;
  final bool urgent;
  final bool showEdit;
  final bool showFavourite;
  final RxBool? isFavourite;
  final VoidCallback onViewDetails;
  final VoidCallback? onEdit;
  final VoidCallback? onFavouriteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Image + Badge + Favourite ---
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 160.h,
                  fit: BoxFit.cover,
                ),
              ),
              // --- Badge ---
              Positioned(
                top: 10.h,
                right: 10.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: showEdit
                        ? const Color(0xFFDFF7DF) // active (green bg)
                        : const Color(0xFFDDE9FF), // completed (blue bg)
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    showEdit ? "Active" : "Completed",
                    style: TextStyle(
                      color: showEdit
                          ? Colors.green[700]
                          : Colors.blueAccent[700],
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
              // --- Favourite Icon (only if completed) ---
              if (showFavourite && isFavourite != null)
                Positioned(
                  top: 42.h,
                  right: 14.w,
                  child: Obx(
                    () => GestureDetector(
                      onTap: onFavouriteTap,
                      child: CircleAvatar(
                        radius: 16.r,
                        backgroundColor: Colors.white,
                        child: Icon(
                          isFavourite!.value ? Icons.star : Icons.star_border,
                          size: 18.sp,
                          color: isFavourite!.value
                              ? Colors.yellow[700]
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // --- Details Section ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Title ---
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),

                // --- Location Row ---
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // --- Pay Rate & Applicants ---
                Row(
                  children: [
                    const Icon(
                      Icons.attach_money,
                      size: 18,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "\$18/hour",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.group_outlined,
                      size: 18,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "12 Applied",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // --- Buttons ---
                if (showEdit) // Active Jobs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolor.primaryColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          onPressed: onViewDetails,
                          child: Text(
                            "View Details",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Appcolor.primaryColor),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          onPressed: onEdit,
                          child: Text(
                            "Edit",
                            style: TextStyle(
                              color: Appcolor.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  GestureDetector(
                    child: Container(
                      height: 48.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Appcolor.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'View Details',
                          style: getTextStyle(
                            color: Appcolor.backgroundcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
