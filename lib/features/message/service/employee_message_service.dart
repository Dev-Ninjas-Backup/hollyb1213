import 'dart:developer';
import 'package:readytowork/core/common/constants/api_endpoint.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class EmployeeMessageService {
  static final EmployeeMessageService _instance =
      EmployeeMessageService._internal();

  factory EmployeeMessageService() {
    return _instance;
  }

  EmployeeMessageService._internal();

  io.Socket? _socket;

  void connect(String token) {
    if (_socket != null && _socket!.connected) return;

    try {
      _socket = io.io(
        ApiEndpoint.baseUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .setExtraHeaders({'Authorization': 'Bearer $token'})
            .disableAutoConnect()
            .build(),
      );

      _socket!.connect();

      _socket!.onConnect((_) {
        log('Socket connected: ${_socket?.id}');
      });

      _socket!.onDisconnect((_) {
        log('Socket disconnected');
      });
    } catch (e) {
      log('Socket initialization failed: $e');
    }
  }

  // This is the method that fixes the "on" error in your controller
  void on(String event, Function(dynamic) callback) {
    _socket?.on(event, callback);
  }

  void disconnect() {
    _socket?.disconnect();
  }
}
