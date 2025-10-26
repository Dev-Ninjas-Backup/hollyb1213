import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/auth/role_selection/screen/role_selection_screen.dart';
import 'package:hollyb1213/features/onboarding/controller/onboarding_controller.dart';
import 'package:hollyb1213/features/onboarding/widgets/slider_box_widget.dart';
import 'package:hollyb1213/features/onboarding/widgets/title_style_widget.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());
  final PageController pageController = PageController();

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: PageView.builder(
              controller: pageController,
              itemCount: controller.onboardingData.length,
              onPageChanged: (index) {
                controller.updatePage(index);

                if (index == controller.onboardingData.length - 1) {
                  Future.delayed(Duration(milliseconds: 500), () {
                    Get.off(() => RoleSelectionScreen());
                  });
                }
              },
              itemBuilder: (context, index) {
                final data = controller.onboardingData[index];
                return Container(
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: AssetImage(data["image"]!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.04,
                        right: width * 0.04,
                      ),
                      child: TextButton(
                        onPressed: controller.skip,
                        child: Text(
                          'Skip',
                          style: getTextStyle(
                            color: Colors.white,
                            fontSize: width * 0.040,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: height * 0.05),

          TitleStyle(controller: controller, width: width, height: height),

          SizedBox(height: height * 0.02),

          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.onboardingData.length,
                (index) => SliderBox(
                  isFilled: index <= controller.currentPage.value,
                  width: width,
                  height: height,
                ),
              ),
            );
          }),

          SizedBox(height: height * 0.07),
        ],
      ),
    );
  }
}
