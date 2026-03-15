
class ChatMessage {
  final String message;
  final bool isSentByMe;
  final String time;
  final String status;

  ChatMessage({
    required this.message,
    required this.isSentByMe,
    required this.time,
    this.status = 'SENT',
  });
}
