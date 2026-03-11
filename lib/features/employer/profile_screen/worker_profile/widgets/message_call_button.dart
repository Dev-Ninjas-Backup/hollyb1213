import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/constants/appcolor.dart';
import '../../../../../core/common/style/global_text_style.dart';

class MessageAndCallButton extends StatelessWidget {
  final String? phoneNumber;

  static const platform = MethodChannel('com.hollybdev.hollyb1213/call');

  const MessageAndCallButton({
    super.key,
    this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 12.w,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 14.w,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Messages",
                  style: getBodyTextStyle(
                    color: Colors.white,
                    fontSize: sp(14),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.message_rounded,
                  size: sp(20),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () => _makePhoneCall(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 14.w,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Call Now",
                  style: getBodyTextStyle(
                    color: Colors.white,
                    fontSize: sp(14),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.call, size: sp(20), color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _makePhoneCall() async {
    print('DEBUG: Phone number: $phoneNumber');

    if (phoneNumber == null || phoneNumber!.isEmpty) {
      print('DEBUG: Phone number is null or empty');
      return;
    }

    try {
      print('DEBUG: Making direct call to: $phoneNumber');
      await platform.invokeMethod('makeCall', {'phoneNumber': phoneNumber});
      print('DEBUG: Call initiated successfully');
    } on PlatformException catch (e) {
      print('DEBUG: Failed to make call: ${e.message}');
    } catch (e) {
      print('DEBUG: Error making phone call: $e');
    }
  }
}
