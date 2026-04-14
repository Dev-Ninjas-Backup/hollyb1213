import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/onboarding/controller/onboarding_controller.dart';


class TitleStyle extends StatelessWidget {
  const TitleStyle({
    super.key,
    required this.controller,
    required this.width,
    required this.height,
  });

  final OnboardingController controller;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Obx(() {
        final data = controller.onboardingData[controller.currentPage.value];
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Text(
                data["title"]!,
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Text(
                data["subtitle"]!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: width * 0.04,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
