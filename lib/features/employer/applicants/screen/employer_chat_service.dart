import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as io;

class EmployerChatService {
  io.Socket? socket;

  void connect(String token, {required Function onConnect}) {
    // The endpoint for chat seems to be the same for both.
    // The server will differentiate based on the token.
    socket = io.io(
      "http://16.16.114.137:5000/pv/message", // Connect to root namespace first
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({'token': 'Bearer $token'})
          .build(),
    );

    socket!.connect();

    socket!.onConnect((_) {
      log("✅ Employer Chat socket connected");
      onConnect();
    });
    socket!.onDisconnect((_) => log("❌ Employer Chat socket disconnected"));
    socket!.onError((data) => log("Employer Chat Socket Error: $data"));
    socket!.onAny(
        (event, data) => log("Employer Chat Event: '$event', Data: $data"));
  }

  void loadConversation(String conversationId) {
    socket?.emit('private:load_single_conversation',
        {"conversationId": conversationId, "page": 1, "limit": 50});
  }

  void loadConversations() {
    socket?.emit("private:load_conversations");
  }

  void listenConversationList(Function(dynamic) onList) {
    socket?.on('private:conversation_list', onList);
  }

  void sendMessage(String recipientId, String message) {
    socket?.emit('private:send_message',
        {"recipientId": recipientId, "content": message, "type": "TEXT"});
  }

  void listenMessages(Function(dynamic) onMessage) {
    socket?.on('private:single_conversation', onMessage);
  }

  void listenNewMessage(Function(dynamic) onMessage) {
    socket?.on('private:new_message', onMessage);
  }

  void disconnect() {
    if (socket != null) {
      socket!.disconnect();
    }
  }
}
