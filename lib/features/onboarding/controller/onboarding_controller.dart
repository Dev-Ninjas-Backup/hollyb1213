import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';
import 'package:hollyb1213/routes/app_route.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();

  final List<Map<String, String>> onboardingData = [
    {
      "image": Imagepath.rectangle1,
      "title": "Find Jobs Near You Instantly",
      "subtitle":
          "Discover nearby same-day jobs that match your skills and start earning in just a few taps.",
    },
    {
      "image": Imagepath.rectangle2,
      "title": "Earn & Get Paid Quickly",
      "subtitle":
          "Track your completed jobs and receive\n payments directly in your wallet — safe and fast.",
    },
    {
      "image": Imagepath.rectangle3,
      "title": "Flexible Schedule, Your Choice",
      "subtitle":
          "Choose when and where you want to work — no commitments, no stress, just freedom.",
    },
  ];

  bool get isLastPage => currentPage.value == onboardingData.length - 1;

  void skip() {
    Get.offAllNamed(AppRoute.getroleSelection());
  }

  void nextPage() {
    if (isLastPage) {
      skip();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void updatePage(int index) {
    currentPage.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
