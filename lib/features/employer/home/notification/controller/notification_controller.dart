import 'dart:developer';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import '../service/employer_notification_service.dart';

class NotificationController extends GetxController {
  final notifications = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  final EmployerNotificationService _service = EmployerNotificationService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  @override
  void onInit() {
    super.onInit();
    _initializeSocket();
  }

  void _initializeSocket() async {
    isLoading.value = true;
    final token = await _prefs.getAccessToken();
    if (token != null && token.isNotEmpty) {
      connectSocket(token);
    } else {
      isLoading.value = false;
      log("Auth token not found, can't connect to employer notification socket.");
    }
  }

  void connectSocket(String token) {
    _service.connect(token);

    /// initial list
    _service.onNotificationList((data) {
      isLoading.value = false;

      if (data != null && data["data"] != null) {
        notifications.assignAll(List<Map<String, dynamic>>.from(data["data"]));
      }
    });

    /// realtime new notification
    _service.onNewNotification((data) {
      if (data != null) {
        notifications.insert(0, Map<String, dynamic>.from(data));
      }
    });

    _service.loadNotifications();
  }

  void markAsRead(String id) {
    _service.markAsRead(id);
  }

  @override
  void onClose() {
    _service.dispose();
    super.onClose();
  }
}
