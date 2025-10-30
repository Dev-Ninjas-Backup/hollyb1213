import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomShadowContainer extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Offset? offset;
  final double? blurRadius;
  final double? spreadRadius;
  final EdgeInsetsGeometry? padding;

  const CustomShadowContainer({
    super.key,
    required this.child,
    this.borderRadius,
    this.backgroundColor,
    this.shadowColor,
    this.offset,
    this.blurRadius,
    this.spreadRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          color: backgroundColor ?? Colors.white,
          boxShadow: [
            BoxShadow(
              color:
                  shadowColor ?? const Color(0xFF000000).withValues(alpha: .11),
              offset: offset ?? Offset(0, 0),
              blurRadius: blurRadius ?? 10.r,
              spreadRadius: spreadRadius ?? 0.r,
              blurStyle: BlurStyle.normal,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
