import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class EmployeeChatService {
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

    _socket!.onConnect((_) => log(" Employee Chat socket connected"));
    _socket!.onDisconnect((_) => log(" Employee Chat socket disconnected"));
    _socket!.onError((data) => log("Employee Chat Socket Error: $data"));
    _socket!.onAny((event, data) {
      log("Employee Chat Event Received: '$event', Data: $data");
    });
  }

  void loadConversation(String conversationId) {
    _socket?.emit('private:load_single_conversation',
        {"conversationId": conversationId, "page": 1, "limit": 20});
  }

  void sendMessage(String recipientId, String message) {
    _socket?.emit('private:send_message',
        {"recipientId": recipientId, "content": message, "type": "TEXT"});
  }

  void listenMessages(Function(dynamic) onMessage) {
    // This should listen for the list of messages for a conversation
    _socket?.off('private:conversation_messages');
    _socket?.on('private:conversation_messages', (data) {
      onMessage(data);
    });
  }

  void listenNewMessage(Function(dynamic) onMessage) {
    _socket?.off('private:new_message');
    _socket?.on('private:new_message', (data) {
      onMessage(data);
    });
  }

  void disconnect() {
    // We should not disconnect the socket when a chat screen is closed,
    // as it's inefficient to reconnect every time.
    // The socket connection should be managed more globally.
  }
}
