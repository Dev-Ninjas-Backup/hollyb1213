import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:readytowork/features/employee/chat/model/chat_message_model.dart';
import 'package:readytowork/features/employer/applicants/screen/employer_chat_service.dart';


class EmployerChatController extends GetxController {
  final EmployerChatService _service = EmployerChatService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  final String recipientId;

  EmployerChatController({required this.recipientId});

  final textController = TextEditingController();
  final scrollController = ScrollController();

  var messages = <ChatMessage>[].obs;
  var isLoading = true.obs;
  String? currentUserId;

  @override
  void onInit() {
    super.onInit();
    _initChat();
  }

  Future<void> _initChat() async {
    try {
      isLoading.value = true;
      currentUserId = await _prefs.getUserId();
      final token = await _prefs.getAccessToken();

      if (token == null || token.isEmpty) {
        log("Token not found. Cannot connect chat socket.");
        isLoading.value = false;
        return;
      }

      _service.connect(token, onConnect: () {
        log("Socket connected. Requesting conversation list.");
        _service.loadConversations();
      });

      // Attach listeners AFTER connect() is called so the socket is initialized.
      _service.listenMessages((data) {
        if (data is Map && data.containsKey('messages')) {
          final List list = data["messages"] ?? [];
          messages.value = list
              .map((e) {
                final senderId = e['sender']?['id'] as String?;
                return ChatMessage(
                  message: e["content"] ?? "",
                  isSentByMe: senderId != null && senderId == currentUserId,
                  time: e["createdAt"] ?? "",
                );
              })
              .toList()
              .reversed
              .toList();
        }
        isLoading.value = false;
        _scrollToBottom(jump: true);
      });

      _service.listenNewMessage((data) {
        final senderId = data['sender']?['id'] as String?;
        final newMessage = ChatMessage(
          message: data["content"] ?? "",
          isSentByMe: senderId != null && senderId == currentUserId,
          time: data["createdAt"] ?? "",
        );
        messages.insert(0, newMessage);
        _scrollToBottom();
      });

      _service.listenConversationList((data) {
        log("Received conversation list: $data");
        if (data is List) {
          final conversation = data.firstWhere(
            (convo) => convo['participant']?['id'] == recipientId,
            orElse: () => null,
          );

          if (conversation != null) {
            final conversationId = conversation['conversationId'] as String?;
            if (conversationId != null) {
              log("Found existing conversation. ID: $conversationId. Loading messages.");
              _service.loadConversation(conversationId);
              // Stop loading indicator here to prevent getting stuck if server
              // doesn't respond with message history. The list will populate
              // when/if the `listenMessages` callback is fired.
              isLoading.value = false;
            }
          } else {
            log("No existing conversation found for recipient: $recipientId. This is a new chat.");
            isLoading.value = false;
            messages.clear();
          }
        }
      });
    } catch (e) {
      log("Chat initialization error: $e");
      isLoading.value = false;
    }
  }

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    // Emit the message to the server.
    _service.sendMessage(recipientId, text);

    // Clear the input. The message will appear when the server echo is received
    // via the `listenNewMessage` listener. This prevents duplicate messages.
    textController.clear();
  }

  void _scrollToBottom({bool jump = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        final position = scrollController.position.minScrollExtent;
        if (jump) {
          scrollController.jumpTo(position);
        } else {
          scrollController.animateTo(position,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        }
      }
    });
  }

  @override
  void onClose() {
    _service.disconnect();
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
