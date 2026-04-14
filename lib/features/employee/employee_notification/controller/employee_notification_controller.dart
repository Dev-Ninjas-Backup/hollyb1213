import 'dart:developer';
import 'package:get/get.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:readytowork/features/employee/employee_notification/screen/rest_notification_service.dart';
import '../service/notification_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class EmployeeNotificationController extends GetxController {
  final NotificationService _socketService = NotificationService();
  final RestNotificationService _restService = RestNotificationService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  final notifications = <Map<String, dynamic>>[].obs;
  final unreadCount = 0.obs;
  final isLoading = true.obs;

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
      _updateUnreadCount();
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
      log("Auth token not found, can't connect to notification socket.");
    }
  }

  void connectSocket(String token) {
    _socketService.connect(token);

    /// connected event
    _socketService.onConnected((data) {
      log("Connected: $data");
      if (data["unreadCount"] != null) {
        unreadCount.value = data["unreadCount"];
      }
    });

    /// realtime new notification
    _socketService.onNewNotification((data) {
      log("New Notification: $data");

      // The data from socket might have a different structure.
      // We format it to match the REST response structure.
      final newNotification = {
        'id': data['userNotificationId'], // This is the UserNotification ID
        'read': data['read'] ?? false,
        'title': data['title'] ?? 'No Title',
        'message': data['message'] ?? 'No Message',
        'createdAt': _formatDate(data['createdAt']),
        'type': data['type'] ?? '',
        'meta': data['meta'] ?? {},
      };

      notifications.insert(0, newNotification);
      _updateUnreadCount();
    });

    /// unread count update
    _socketService.onUnreadCount((data) {
      unreadCount.value = data["count"] ?? 0;
    });
  }

  void _updateUnreadCount() {
    unreadCount.value = notifications.where((n) => n['read'] == false).length;
  }

  void markRead(String userNotificationId) {
    try {
      final index =
          notifications.indexWhere((n) => n['id'] == userNotificationId);
      if (index != -1) {
        final notification = notifications[index];
        if (notification['read'] == false) {
          // Mark as read on the backend via REST
          _restService.markNotificationAsRead(userNotificationId);

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

  void markAllRead() {
    _socketService.markAllRead(); // Assuming this is a socket feature
  }

  @override
  void onClose() {
    _socketService.disconnect();
    super.onClose();
  }
}
