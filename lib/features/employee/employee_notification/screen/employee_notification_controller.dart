import 'package:get/get.dart';
import 'package:readytowork/features/employee/employee_notification/screen/rest_notification_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class EmployeeNotificationController extends GetxController {
  final RestNotificationService _notificationService =
      RestNotificationService();

  var isLoading = true.obs;
  var notifications = <Map<String, dynamic>>[].obs;
  var unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'Just now';
    }
    try {
      final dateTime = DateTime.parse(dateString);
      return timeago.format(dateTime);
    } catch (e) {
      // In case of a parsing error, return the original string.
      return dateString;
    }
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      final fetchedNotifications =
          await _notificationService.getNotifications();

      // Process notifications to format the date into a "time ago" format.
      final processedNotifications = fetchedNotifications.map((n) {
        return {
          ...n,
          'createdAt': _formatDate(n['createdAt']),
        };
      }).toList();

      notifications.value = processedNotifications;
      _updateUnreadCount();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load notifications: ${e.toString()}');
      notifications.value = []; // Clear list on error
    } finally {
      isLoading.value = false;
    }
  }

  void _updateUnreadCount() {
    unreadCount.value = notifications.where((n) => n['read'] == false).length;
  }

  Future<void> markRead(String notificationId) async {
    try {
      final index = notifications.indexWhere((n) => n['id'] == notificationId);
      if (index != -1) {
        final notification = notifications[index];
        if (notification['read'] == false) {
          // Mark as read on the backend
          await _notificationService.markNotificationAsRead(notificationId);

          // Update locally for immediate UI feedback
          notification['read'] = true;
          notifications[index] = notification;
          _updateUnreadCount();
          notifications.refresh();
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to mark as read: ${e.toString()}');
    }
  }
}
