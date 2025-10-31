import 'package:get/get.dart';

class EmployeeNotificationController extends GetxController {
  final notifications = <Map<String, String>>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() {
    isLoading.value = true;

    notifications.assignAll([
      {
        'title': 'Booking Confirmed',
        'message': 'Your booking for Space A has been confirmed successfully.',
        'time': '2h ago',
      },
      {
        'title': 'Profile Updated',
        'message': 'You have successfully updated your profile information.',
        'time': '5h ago',
      },
      {
        'title': 'Payment Successful',
        'message': 'Payment of \$45.00 for booking #12345 completed.',
        'time': '1d ago',
      },
      {
        'title': 'New Message',
        'message': 'You received a new message from Matthew Evan.',
        'time': '2d ago',
      },
      {
        'title': 'New Message',
        'message': 'You received a new message from Matthew Evan.',
        'time': '2d ago',
      },
    ]);

    isLoading.value = false;
  }
}
