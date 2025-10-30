import 'package:get/get.dart';
import 'package:hollyb1213/features/employee/chat/model/chat_message_model.dart';

class ChatController extends GetxController {
  var messages = <ChatMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadChat();
  }

  void loadChat() {
    messages.value = [
      ChatMessage(
        message:
            "Hi! Thank you for applying to the Restaurant Helper position.",
        isSentByMe: false,
        time: "10:30 PM",
      ),
      ChatMessage(
        message:
            "Hello! I'm very interested in this opportunity. When can I start?",
        isSentByMe: true,
        time: "10:32 PM",
      ),
      ChatMessage(
        message:
            "Great enthusiasm! We have an opening starting tomorrow. Are you available for a quick phone interview today?",
        isSentByMe: false,
        time: "10:35 PM",
      ),
      ChatMessage(
        message: "Yes, absolutely! I'm available anytime after 2 PM today.",
        isSentByMe: true,
        time: "10:38 PM",
      ),
      ChatMessage(
        message:
            "Perfect! I'll call you at 3 PM. Please have your ID and any relevant certificates ready.",
        isSentByMe: false,
        time: "10:40 PM",
      ),
    ];
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    messages.add(
      ChatMessage(message: text.trim(), isSentByMe: true, time: "Now"),
    );
  }
}
