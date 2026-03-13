class MessageModel {
  final String conversationId;
  final String recipientId;
  final String name;
  final String company;
  final String message;
  final String timeAgo;
  final String imageUrl;
  final bool isOnline;

  MessageModel({
    required this.conversationId,
    required this.recipientId,
    required this.name,
    required this.company,
    required this.message,
    required this.timeAgo,
    required this.imageUrl,
    this.isOnline = false,
  });
}
