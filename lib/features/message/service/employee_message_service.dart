import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class EmployeeMessageService {
  IO.Socket? _socket;

  IO.Socket get socket => _socket!;

  void connect(String token) {
    if (_socket?.connected ?? false) {
      return;
    }
    _socket = IO.io(
      "http://16.16.114.137:5000/pv/message", // Connect to root namespace
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({'token': 'Bearer $token'})
          .build(),
    );

    _socket!.connect();

    _socket!.onConnect((_) => log(" Employee Message List socket connected"));
    _socket!
        .onDisconnect((_) => log("Employee Message List socket disconnected"));
    _socket!
        .onError((data) => log("Employee Message List Socket Error: $data"));
    _socket!.onAny((event, data) {
      log("Employee Message List Event Received: '$event', Data: $data");
    });
  }

  void loadConversations() {
    _socket?.emit("private:load_conversations");
  }

  void listenConversations(Function(dynamic) onData) {
    _socket?.off("private:conversation_list");
    _socket?.on("private:conversation_list", (data) {
      onData(data);
    });
  }

  void disconnect() {
    // To maintain a persistent connection, we avoid disconnecting.
    // The socket lifecycle should be managed globally for the app session.
    // _socket?.disconnect();
    // _socket = null;
  }
}
