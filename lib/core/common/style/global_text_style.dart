import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:hollyb1213/core/common/constants/appcolor.dart';

TextStyle getTextStyle({
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.w400,
  TextAlign textAlign = TextAlign.center,
  Color color = Appcolor.primaryColor,
}) {
  return GoogleFonts.poppins(
    fontSize: sp(fontSize),
    fontWeight: fontWeight,
    color: color,
  );
}

TextStyle getBodyTextStyle({
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.w400,
  TextAlign textAlign = TextAlign.center,
  Color color = Appcolor.appTextColor,
}) {
  return GoogleFonts.poppins(
    fontSize: sp(fontSize),
    fontWeight: fontWeight,
    color: color,
  );
}
double sp(double baseSize) {
  double scale = ScreenUtil().screenWidth / 375;
  if (scale > 1.2) scale = 1.2;
  return baseSize * scale;
}
