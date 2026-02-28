import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/features/splash/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller, which will handle the navigation logic.
    Get.put(SplashController());
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
