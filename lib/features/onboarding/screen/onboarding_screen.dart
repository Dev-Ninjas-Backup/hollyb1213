import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/onboarding/controller/onboarding_controller.dart';
import 'package:readytowork/features/onboarding/widgets/slider_box_widget.dart';
import 'package:readytowork/features/onboarding/widgets/title_style_widget.dart';


class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

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
              controller: controller.pageController,
              itemCount: controller.onboardingData.length,
              onPageChanged: controller.updatePage,
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
                      child: Obx(() => Visibility(
                            visible: !controller.isLastPage,
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
                          )),
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
          SizedBox(height: height * 0.04),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Obx(() => SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: controller.nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      controller.isLastPage ? "Get Started" : "Next",
                      style: getTextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )),
          ),
          SizedBox(height: height * 0.03),
        ],
      ),
    );
  }
}
