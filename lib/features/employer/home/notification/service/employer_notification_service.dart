import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as io;

class EmployerNotificationService {
  io.Socket? socket;

  void connect(String token) {
    socket = io.io(
      "http://16.16.114.137:5000/notifications",
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({
            "token": "Bearer $token",
          })
          .build(),
    );

    socket!.connect();

    socket!.onConnect((_) {
      log(" Employer Notification socket connected");
    });

    socket!.onDisconnect((_) {
      log(" Employer Notification socket disconnected");
    });

    socket!.onError((data) {
      log("Employer Socket Error: $data");
    });

    // This will log every event received from the socket for debugging.
    socket!.onAny((event, data) {
      log("Employer Socket Event Received: '$event', Data: $data");
    });
  }

  /// listen notification list
  void onNotificationList(Function(dynamic data) callback) {
    socket?.on("notification:list", callback);
  }

  /// listen new notification
  void onNewNotification(Function(dynamic data) callback) {
    socket?.on("notification:new", callback);
  }

  /// mark notification as read
  void markAsRead(String id) {
    socket?.emit("notification:mark_read", {
      "id": id,
    });
  }

  /// load notifications
  void loadNotifications() {
    socket?.emit("notification:load", {});
  }

  /// load more
  void loadMore(int page) {
    socket?.emit("notification:load_more", {
      "page": page,
    });
  }

  void dispose() {
    socket?.dispose();
  }
}
