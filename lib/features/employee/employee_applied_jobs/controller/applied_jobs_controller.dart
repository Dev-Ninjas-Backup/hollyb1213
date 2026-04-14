import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/imagepath.dart';
import 'package:readytowork/features/employee/employee_applied_jobs/kitchen_helper/screen/kitchen_helper_screen.dart';
import 'package:readytowork/features/employer/jobs/models/job_model.dart';


class AppliedJobsController extends GetxController {
  var selectedTab = 0.obs;

  List<Map<String, dynamic>> completedJobs = [
    {
      'image': Imagepath.image2,
      'title': 'Waiter',
      'company': 'City Cafe',
      'distance': '1.5 km away',
      'rate': '\$19/hour',
      'time': '27 October 8:00 AM - 4:00 PM',
      'status': 'Completed',
      'statusColor': 0xFF27AE60,
      'progressText': '',
      'onTap': () => Get.snackbar('Waiter', 'Navigate to Waiter Details'),
    },
    {
      'image': Imagepath.image1,
      'title': 'Barista',
      'company': 'Coffee Hub',
      'distance': '1.1 km away',
      'rate': '\$22/hour',
      'time': '25 October 9:00 AM - 3:00 PM',
      'status': 'Completed',
      'statusColor': 0xFF27AE60,
      'progressText': '',
      'onTap': () => Get.snackbar('Barista', 'Navigate to Barista Details'),
    },
    {
      'image': Imagepath.rectangle1,
      'title': 'Waiter',
      'company': 'City Cafe',
      'distance': '1.5 km away',
      'rate': '\$19/hour',
      'time': '27 October 8:00 AM - 4:00 PM',
      'status': 'Completed',
      'statusColor': 0xFF27AE60,
      'progressText': '',
      'onTap': () => Get.snackbar('Waiter', 'Navigate to Waiter Details'),
    },
    {
      'image': Imagepath.rectangle2,
      'title': 'Barista',
      'company': 'Coffee Hub',
      'distance': '1.1 km away',
      'rate': '\$22/hour',
      'time': '25 October 9:00 AM - 3:00 PM',
      'status': 'Completed',
      'statusColor': 0xFF27AE60,
      'progressText': '',
      'onTap': () => Get.snackbar('Barista', 'Navigate to Barista Details'),
    },
  ];

  void navigateToJobDetails(JobModel job) {
    Get.to(() => KitchenHelperScreen(job: job));
  }
}
