import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_button.dart';

class EmployerJobCard extends StatelessWidget {
  const EmployerJobCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.distance,
    required this.urgent,
    required this.buttonText,
    required this.onPressed,
  });

  final String image;
  final String title;
  final String subtitle;
  final String distance;
  final bool urgent;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: Image.asset(
              image,
              height: 140.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (urgent)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          "Urgent",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.blue, size: 18),
                    SizedBox(width: 4.w),
                    Text(
                      distance,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Icon(Icons.attach_money, color: Colors.black, size: 18),
                    Text(
                      "\$18/hour",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                CustomButton(buttonText: buttonText, onTap: onPressed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
