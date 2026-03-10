import 'dart:developer';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import '../service/notification_service.dart';

class EmployeeNotificationController extends GetxController {
  final NotificationService _service = NotificationService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  final notifications = <Map<String, dynamic>>[].obs;
  final unreadCount = 0.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeSocket();
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
    _service.connect(token);

    /// connected event
    _service.onConnected((data) {
      log("Connected: $data");
      unreadCount.value = data["unreadCount"] ?? 0;
    });

    /// initial list
    _service.onNotificationList((data) {
      isLoading.value = false;

      final list = data["data"] ?? [];
      notifications.assignAll(List<Map<String, dynamic>>.from(list));
    });

    /// realtime new notification
    _service.onNewNotification((data) {
      log("New Notification: $data");

      notifications.insert(0, data);
    });

    /// unread count update
    _service.onUnreadCount((data) {
      unreadCount.value = data["count"] ?? 0;
    });

    loadNotifications();
  }

  void loadNotifications() {
    isLoading.value = true;
    _service.loadNotifications();
  }

  void markRead(String id) {
    _service.markAsRead([id]);
  }

  void markAllRead() {
    _service.markAllRead();
  }

  @override
  void onClose() {
    _service.disconnect();
    super.onClose();
  }
}
