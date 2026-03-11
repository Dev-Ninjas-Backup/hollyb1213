import 'dart:developer';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/employee/employee_notification/screen/rest_notification_service.dart';
import '../service/employer_notification_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationController extends GetxController {
  final notifications = <Map<String, dynamic>>[].obs;
  final isLoading = true.obs;

  final EmployerNotificationService _socketService =
      EmployerNotificationService();
  final RestNotificationService _restService = RestNotificationService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  @override
  void onInit() {
    super.onInit();
    fetchInitialNotifications();
    _initializeSocket();
  }

  Future<void> fetchInitialNotifications() async {
    try {
      isLoading.value = true;
      final fetchedNotifications = await _restService.getNotifications();

      final processedNotifications = fetchedNotifications.map((n) {
        return {
          ...n,
          'createdAt': _formatDate(n['createdAt']),
        };
      }).toList();

      notifications.value = processedNotifications;
    } catch (e) {
      log('Failed to load notifications via REST: $e');
      Get.snackbar('Error', 'Failed to load notifications.');
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

  void _initializeSocket() async {
    final token = await _prefs.getAccessToken();
    if (token != null && token.isNotEmpty) {
      connectSocket(token);
    } else {
      log("Auth token not found, can't connect to employer notification socket.");
    }
  }

  void connectSocket(String token) {
    _socketService.connect(token);

    /// realtime new notification
    _socketService.onNewNotification((data) {
      log("New Employer Notification: $data");
      if (data != null) {
        // Format socket data to match REST data structure
        final newNotification = {
          'id': data['userNotificationId'],
          'read': data['read'] ?? false,
          'title': data['title'] ?? 'No Title',
          'message': data['message'] ?? 'No Message',
          'createdAt': _formatDate(data['createdAt']),
          'type': data['type'] ?? '',
          'meta': data['meta'] ?? {},
        };
        notifications.insert(0, newNotification);
      }
    });
  }

  Future<void> markAsRead(String notificationId) async {
    final index = notifications.indexWhere((n) => n['id'] == notificationId);
    if (index != -1 && notifications[index]['read'] == false) {
      await _restService.markNotificationAsRead(notificationId);
      notifications[index]['read'] = true;
      notifications.refresh();
    }
  }

  @override
  void onClose() {
    _socketService.dispose();
    super.onClose();
  }
}
