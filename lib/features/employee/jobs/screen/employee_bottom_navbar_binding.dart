import 'package:get/get.dart';
import 'package:hollyb1213/features/employee/bottom_navbar/controller/employee_bottom_navbar_controller.dart';
import 'package:hollyb1213/features/employee/home/controller/employe_home_controller.dart';
import 'package:hollyb1213/features/employee/jobs/controller/employee_jobs_controller.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/widgets/employee_profile_controller.dart';
import 'package:hollyb1213/features/message/controller/message_controller.dart';

class EmployeeBottomNavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeBottomNavbarController());
    Get.lazyPut(() => EmployeHomeController());
    Get.lazyPut(() => EmployeeJobsController());
    Get.lazyPut(() => MessageController());
    Get.lazyPut(() => EmployeeProfileController());
  }
}
