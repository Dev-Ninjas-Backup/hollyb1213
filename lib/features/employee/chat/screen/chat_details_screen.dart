import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employee/chat/controller/chat_message_controller.dart';

class ChatDetailScreen extends StatelessWidget {
  final String name;
  final String company;
  final String imageUrl;
  final bool isOnline;

  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.company,
    required this.imageUrl,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    final textController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 20),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: getTextStyle(
                    color: Appcolor.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      company,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    if (isOnline) ...[
                      SizedBox(width: 6),
                      Text(
                        "Online",
                        style: getTextStyle(
                          color: Colors.green,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Text(
            "24 July, 2025",
            style: getTextStyle(color: Colors.grey.shade500, fontSize: 13),
          ),
          SizedBox(height: 10),

          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                physics: BouncingScrollPhysics(),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];
                  return Column(
                    crossAxisAlignment: msg.isSentByMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: msg.isSentByMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!msg.isSentByMe)
                            CircleAvatar(
                              backgroundImage: NetworkImage(imageUrl),
                              radius: 18,
                            ),
                          SizedBox(width: 6),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: msg.isSentByMe
                                    ? Colors.blue.shade100
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                  bottomLeft: msg.isSentByMe
                                      ? Radius.circular(16)
                                      : Radius.circular(0),
                                  bottomRight: msg.isSentByMe
                                      ? Radius.circular(0)
                                      : Radius.circular(16),
                                ),
                              ),
                              child: Text(
                                msg.message,
                                style: getTextStyle(
                                  color: Colors.black87,
                                  fontSize: 14.5,
                                ),
                              ),
                            ),
                          ),
                          if (msg.isSentByMe) const SizedBox(width: 6),
                          if (msg.isSentByMe)
                            const CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                "https://randomuser.me/api/portraits/men/7.jpg",
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 8,
                          left: 8,
                          bottom: 6,
                        ),
                        child: Text(
                          msg.time,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11.5,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          // Message Input
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.blue.shade50,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: "Send message",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  height: 45,
                  width: 45,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 22),
                    onPressed: () {
                      controller.sendMessage(textController.text);
                      textController.clear();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
