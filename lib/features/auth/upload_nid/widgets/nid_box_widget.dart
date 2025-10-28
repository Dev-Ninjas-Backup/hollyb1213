import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';

class BoxNid extends StatelessWidget {
  const BoxNid({
    super.key,
    required this.image,
    required this.onPick,
    required this.onRemove,
    required this.label,
  });

  final File? image;
  final VoidCallback onPick;
  final VoidCallback onRemove;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Appcolor.primaryColor,
      strokeWidth: 2.2,
      dashPattern: [8, 5],
      borderType: BorderType.RRect,
      radius: Radius.circular(10),
      child: Container(
        width: double.infinity,
        height: 175,
        padding: EdgeInsets.all(10),
        child: image != null
            ? Stack(
                children: [
                  Center(
                    child: Image.file(image!, height: 165, fit: BoxFit.contain),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 3),
                          ],
                        ),
                        child: Icon(Icons.close, color: Appcolor.primaryColor),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Iconpath.nid, height: 41, width: 72),
                  SizedBox(height: 10),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: getBodyTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: onPick,
                    icon: Icon(
                      Icons.camera_alt,
                      size: 22,
                      color: Appcolor.primaryColor,
                    ),
                    label: Text(
                      'Upload Photo',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: BorderSide(
                        color: Appcolor.primaryColor,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
