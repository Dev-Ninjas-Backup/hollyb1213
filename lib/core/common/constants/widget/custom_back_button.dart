import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';

class CustomBackButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final double iconSize;
  final VoidCallback? onTap;

  const CustomBackButton({
    super.key,
    this.backgroundColor = Colors.white,
    this.iconColor = Appcolor.primaryColor,
    this.size = 32,
    this.iconSize = 20,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          onPressed: onTap ?? () => Get.back(),
          icon: Icon(Icons.arrow_back, color: iconColor, size: iconSize),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
    );
  }
}
