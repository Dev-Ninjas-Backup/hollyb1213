import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';
import 'package:hollyb1213/routes/app_route.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

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

  void skip() {
    Get.offNamed(AppRoute.getroleSelection());
  }

  void updatePage(int index) {
    currentPage.value = index;
  }
}
