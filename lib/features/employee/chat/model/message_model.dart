class MessageModel {
  final String name;
  final String company;
  final String message;
  final String timeAgo;
  final String imageUrl;
  final bool isOnline;

  MessageModel({
    required this.name,
    required this.company,
    required this.message,
    required this.timeAgo,
    required this.imageUrl,
    this.isOnline = false,
  });
}
