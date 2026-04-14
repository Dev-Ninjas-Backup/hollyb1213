import 'package:get/get.dart';
import 'package:readytowork/features/employee/employee_notification/screen/rest_notification_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationController extends GetxController {
  final RestNotificationService _restService = RestNotificationService();

  var isLoading = true.obs;
  var notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      // Reusing the same REST service as it uses the generic user ID
      final fetchedNotifications = await _restService.getNotifications();

      final processedNotifications = fetchedNotifications.map((n) {
        return {
          ...n,
          'createdAt': _formatDate(n['createdAt']),
        };
      }).toList();

      notifications.value = processedNotifications;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load notifications');
    } finally {
      isLoading.value = false;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'Just now';
    }
    try {
      final dateTime = DateTime.parse(dateString);
      return timeago.format(dateTime);
    } catch (e) {
      return dateString;
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      final index = notifications.indexWhere((n) => n['id'] == notificationId);
      if (index != -1 && notifications[index]['read'] == false) {
        await _restService.markNotificationAsRead(notificationId);

        notifications[index] = {...notifications[index], 'read': true};
        notifications.refresh();
      }
    } catch (e) {
      // Silently fail or log error
    }
  }
}
