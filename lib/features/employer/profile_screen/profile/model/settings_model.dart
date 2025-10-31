
import 'package:flutter/foundation.dart';

class SettingsModel {
  final String imageUrl;
  final String title;
  final String subTitle;
  final VoidCallback? ontap;

  SettingsModel({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    this.ontap
  });
}
