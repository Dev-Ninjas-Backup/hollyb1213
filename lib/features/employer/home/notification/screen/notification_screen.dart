import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_back_button.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employer/home/notification/controller/notification_controller.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Appcolor.backgroundcolor,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: CustomBackButton(),
        ),
        title: Text(
          "Notifications",
          style: TextStyle(
            color: Appcolor.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: Text(
            "No Notifications Yet",
          ));
        }

        if (controller.notifications.isEmpty) {
          return const Center(
            child: Text(
              "No notifications yet",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: controller.notifications.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = controller.notifications[index];
            return _NotificationListItem(
              item: item,
              onTap: () {
                if (item["id"] != null) {
                  controller.markAsRead(item["id"]);
                }
              },
            );
          },
        );
      }),
    );
  }
}

class _NotificationListItem extends StatefulWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const _NotificationListItem({required this.item, required this.onTap});

  @override
  State<_NotificationListItem> createState() => _NotificationListItemState();
}

class _NotificationListItemState extends State<_NotificationListItem> {
  bool _isExpanded = false;
  static const int _messageLimit = 80;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final message = item["message"] as String? ?? "";
    final canExpand = message.length > _messageLimit;
    final displayMessage = canExpand && !_isExpanded
        ? '${message.substring(0, _messageLimit)}...'
        : message;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: item["read"] == true ? Colors.white : Colors.blue.shade50,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Appcolor.primaryColor.withOpacity(.2),
              child: const Icon(
                Icons.notifications_active,
                size: 22,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["title"] ?? "",
                    style: getTextStyle(
                      fontSize: 16,
                      color: Appcolor.appTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    displayMessage,
                    style: getBodyTextStyle(
                      color: Colors.black.withOpacity(.7),
                    ),
                  ),
                  if (canExpand)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: GestureDetector(
                        onTap: () => setState(() => _isExpanded = !_isExpanded),
                        child: Text(
                          _isExpanded ? "See less" : "See more",
                          style: getBodyTextStyle(
                            color: Appcolor.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 6),
                  Text(
                    item["createdAt"] ?? "",
                    style: getBodyTextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
