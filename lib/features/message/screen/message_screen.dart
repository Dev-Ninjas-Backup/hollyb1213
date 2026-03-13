import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/message/controller/message_controller.dart';
import 'package:hollyb1213/features/employee/chat/screen/chat_details_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MessageController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Messages",
                style: getTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Appcolor.primaryColor,
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: (value) => controller.searchQuery.value = value,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search conversations...",
                    icon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.filteredMessages.length,
                    itemBuilder: (context, index) {
                      final message = controller.filteredMessages[index];
                      return GestureDetector(
                        onTap: () {
                          // Reset the unread count before navigating
                          controller.resetUnreadCount(message.conversationId);
                          Get.to(
                            () => ChatDetailScreen(
                              conversationId: message.conversationId,
                              recipientId: message.recipientId,
                              recipientName: message.name,
                              recipientAvatarUrl: message.imageUrl,
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 1,
                                  offset: const Offset(2, 3),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage:
                                          message.imageUrl.isNotEmpty
                                              ? NetworkImage(message.imageUrl)
                                              : null,
                                      child: message.imageUrl.isEmpty
                                          ? const Icon(Icons.person,
                                              color: Colors.grey)
                                          : null,
                                    ),
                                    if (message.isOnline)
                                      Positioned(
                                        bottom: 2,
                                        right: 1,
                                        child: Container(
                                          height: 12.h,
                                          width: 12.w,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              message.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            message.timeAgo,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text(
                                            message.company
                                                .toUpperCase(), // Role
                                            style: TextStyle(
                                              color: Appcolor.primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            width: 4,
                                            height: 4,
                                            decoration: const BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle),
                                          ),
                                          // Text(
                                          //   "READ", // Status (Hardcoded as per requirement to show status, or map dynamic if available)
                                          //   style: TextStyle(
                                          //     color: Colors.grey.shade500,
                                          //     fontSize: 11,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      if (message.unreadCount > 0)
                                        Text(
                                          '${message.unreadCount} new unread message${message.unreadCount > 1 ? 's' : ''}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Appcolor.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        )
                                      //   else
                                      // Text(
                                      //   message.message,
                                      //   maxLines: 1,
                                      //   overflow: TextOverflow.ellipsis,
                                      //   style: TextStyle(
                                      //     color: Colors.grey.shade600,
                                      //     fontSize: 14,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
