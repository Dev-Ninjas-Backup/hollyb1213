import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';
import 'package:hollyb1213/features/employee/employee_applied_jobs/kitchen_helper/screen/kitchen_helper_screen.dart';

class AppliedJobsController extends GetxController {
  var selectedTab = 0.obs;

  List<Map<String, dynamic>> activeJobs = [
    {
      'image': Imagepath.image1,
      'title': 'Kitchen Helper',
      'company': 'City Diner',
      'distance': '1.2 km away',
      'rate': '\$18/hour',
      'time': 'Today 8:00 AM - 4:00 PM',
      'status': 'In Progress',
      'statusColor': 0xFF2ECC71,
      'progressText': '4h 30m remaining',
      'onTap': () {
        Get.to(() => KitchenHelperScreen());
      },
    },
    {
      'image': Imagepath.image2,
      'title': 'Event Staff',
      'company': 'Elite Events',
      'distance': '0.8 km away',
      'rate': '\$24/hour',
      'time': 'Tomorrow 11:00 AM - 7:00 PM',
      'status': 'Confirmed',
      'statusColor': 0xFF3498DB,
      'progressText': '',
      'onTap': () =>
          Get.snackbar('Event Staff', 'Navigate to Event Staff Details'),
    },
    {
      'image': Imagepath.imagefst,
      'title': 'Delivery Driver',
      'company': 'Quick Eats',
      'distance': '0.8 km away',
      'rate': '\$20/hour',
      'time': '30 October 8:00 AM - 5:00 PM',
      'status': 'Pending',
      'statusColor': 0xFFF1C40F,
      'progressText': '',
      'onTap': () => Get.snackbar(
        'Delivery Driver',
        'Navigate to Delivery Driver Details',
      ),
    },
  ];

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
}
