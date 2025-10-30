import 'package:get/get.dart';
import 'package:hollyb1213/features/employee/chat/model/message_model.dart';

class MessageController extends GetxController {
  var messages = <MessageModel>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  void loadMessages() {
    messages.value = [
      MessageModel(
        name: "Sarah Johnson",
        company: "Bella Restaurant",
        message: "Great! Your shift starts at 8 AM...",
        timeAgo: "2 Min ago",
        imageUrl: "https://randomuser.me/api/portraits/women/1.jpg",
        isOnline: true,
      ),
      MessageModel(
        name: "Mike Chen",
        company: "QuickBite Delivery",
        message: "Thanks for accepting the delivery...",
        timeAgo: "1 hour ago",
        imageUrl: "https://randomuser.me/api/portraits/men/2.jpg",
      ),
      MessageModel(
        name: "Emma Rodriguez",
        company: "Green Garden Cafe",
        message: "We received your application...",
        timeAgo: "3 hour ago",
        imageUrl: "https://randomuser.me/api/portraits/women/3.jpg",
      ),
      MessageModel(
        name: "David Park",
        company: "City Mall Security",
        message: "Your background check is completed...",
        timeAgo: "1 day ago",
        imageUrl: "https://randomuser.me/api/portraits/men/4.jpg",
      ),
      MessageModel(
        name: "Lisa Thompson",
        company: "Fresh Market",
        message: "Could you work an extra shift tomorrow?",
        timeAgo: "2 day ago",
        imageUrl: "https://randomuser.me/api/portraits/women/5.jpg",
      ),
      MessageModel(
        name: "James Wilson",
        company: "Downtown Hotel",
        message: "Thank you for your excellent work!",
        timeAgo: "3 day ago",
        imageUrl: "https://randomuser.me/api/portraits/men/6.jpg",
      ),
    ];
  }

  List<MessageModel> get filteredMessages {
    if (searchQuery.value.isEmpty) {
      return messages;
    }
    return messages
        .where(
          (m) =>
              m.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              m.company.toLowerCase().contains(searchQuery.value.toLowerCase()),
        )
        .toList();
  }
}
