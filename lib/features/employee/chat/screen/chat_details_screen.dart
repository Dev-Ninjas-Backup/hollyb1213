import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employee/chat/controller/chat_controller.dart';
import 'package:intl/intl.dart';
import 'package:hollyb1213/features/employee/chat/model/chat_message_model.dart';

class ChatDetailScreen extends StatefulWidget {
  final String conversationId;
  final String recipientId;
  final String recipientName;
  final String recipientAvatarUrl;

  const ChatDetailScreen({
    super.key,
    required this.conversationId,
    required this.recipientId,
    required this.recipientName,
    required this.recipientAvatarUrl,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late final ChatController controller;

  @override
  void initState() {
    super.initState();
    // A unique tag ensures a new controller instance for each chat.
    // `permanent: true` is crucial to preserve the chat history when
    // navigating away and back to the screen.
    controller = Get.put(
      ChatController(
        conversationId: widget.conversationId,
        recipientId: widget.recipientId,
      ),
      tag: widget.conversationId,
      permanent: true,
    );
  }

  String _formatTime(String time) {
    try {
      final dateTime = DateTime.parse(time).toLocal();
      return DateFormat.jm().format(dateTime);
    } catch (e) {
      // Return original string if formatting fails
      return time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundcolor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(widget.recipientName,
            style: getBodyTextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              // Show a loading spinner while fetching the conversation.
              if (controller.isLoading.value && controller.messages.isEmpty) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Appcolor.primaryColor,
                ));
              }
              if (controller.messages.isEmpty) {
                return Center(
                  child: Text(
                    'This is the start of your conversation with ${widget.recipientName}.',
                    textAlign: TextAlign.center,
                    style: getBodyTextStyle(color: Colors.grey.shade600),
                  ),
                );
              }
              return ListView.builder(
                controller: controller.scrollController,
                reverse: true,
                padding: EdgeInsets.all(16.w),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return _buildMessageBubble(message);
                },
              );
            }),
          ),
          _buildMessageInput(controller),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isMe = message.isSentByMe;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 4.h, bottom: 2.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isMe ? Appcolor.primaryColor : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16.r).copyWith(
                bottomRight:
                    isMe ? Radius.circular(4.r) : Radius.circular(16.r),
                bottomLeft:
                    !isMe ? Radius.circular(4.r) : Radius.circular(16.r),
              ),
            ),
            child: Text(
              message.message,
              style: getBodyTextStyle(
                color: isMe ? Colors.white : Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              _formatTime(message.time),
              style: getBodyTextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput(ChatController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, -2)),
        ],
      ),
      // Use SafeArea to avoid system intrusions like the home bar on iOS.
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.textController,
                decoration: const InputDecoration.collapsed(
                    hintText: 'Type a message...'),
                onSubmitted: (_) => controller.sendMessage(),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Appcolor.primaryColor),
              onPressed: controller.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
