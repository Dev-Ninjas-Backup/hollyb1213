import 'package:get/get.dart';
import 'package:readytowork/features/employer/bottom_navbar/controller/employer_bottom_navbar_controller.dart';
import 'package:readytowork/features/employer/home/controller/employer_home_controller.dart';
import 'package:readytowork/features/employer/jobs/controller/employer_jobs_controller.dart';
import 'package:readytowork/features/employer/profile_screen/profile/controller/employer_controllre.dart';
import 'package:readytowork/features/message/controller/message_controller.dart';


class EmployerBottomNavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployerBottomNavbarController());
    Get.lazyPut(() => EmployerHomeController());
    Get.lazyPut(() => EmployerJobsController());
    Get.lazyPut(() => MessageController());
    Get.lazyPut(() => EmployerProfileController());
  }
}
