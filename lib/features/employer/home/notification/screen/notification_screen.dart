import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
        leading: Padding(
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
        if (controller.notifications.isEmpty) {
          return Center(
            child: Text(
              'No notifications yet',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: controller.notifications.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = controller.notifications[index];
            return GestureDetector(
              onTap: () {
                EasyLoading.showInfo('Feature will come with backend');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      // ignore: deprecated_member_use
                      backgroundColor: Appcolor.primaryColor.withOpacity(0.2),
                      child: const Icon(
                        Icons.notifications_active,
                        color: Colors.black,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] ?? '',
                            style: getTextStyle(
                              fontSize: 16,
                              color: Appcolor.appTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['message'] ?? '',
                            style: getBodyTextStyle(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            item['time'] ?? '',
                            style: getBodyTextStyle(
                              // ignore: deprecated_member_use
                              color: Colors.grey.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
