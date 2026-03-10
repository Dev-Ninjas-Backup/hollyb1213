import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  NotificationService._internal();

  IO.Socket? socket;

  void connect(String token) {
    socket = IO.io(
      "http://16.16.114.137:5000/notifications", // Changed to base URL to debug connection. This connects to the default '/' namespace.
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({"token": "Bearer $token"})
          .build(),
    );

    socket!.connect();

    socket!.onConnect((_) {
      log("Notification Socket Connected");
    });

    socket!.onDisconnect((_) {
      log(" Notification Socket Disconnected");
    });

    socket!.onError((data) {
      log("Socket Error: $data");
    });

    // This will log every event received from the socket for debugging.
    socket!.onAny((event, data) {
      log("Socket Event Received: '$event', Data: $data");
    });
  }

  /// Listen connection success
  void onConnected(Function(dynamic) callback) {
    socket?.on("notification:connected", callback);
  }

  /// Receive notification list
  void onNotificationList(Function(dynamic) callback) {
    socket?.on("notification:list", callback);
  }

  /// Listen new notification realtime
  void onNewNotification(Function(dynamic) callback) {
    socket?.on("notification:new", callback);
  }

  /// unread badge update
  void onUnreadCount(Function(dynamic) callback) {
    socket?.on("notification:unread_count", callback);
  }

  /// load notifications
  void loadNotifications({int page = 1, int limit = 20}) {
    socket?.emit("notification:load", {
      "page": page,
      "limit": limit,
    });
  }

  /// mark single notification read
  void markAsRead(List<String> ids) {
    socket?.emit("notification:mark_read", {
      "notificationIds": ids,
    });
  }

  /// mark all read
  void markAllRead() {
    socket?.emit("notification:mark_all_read");
  }

  void disconnect() {
    socket?.disconnect();
  }
}
