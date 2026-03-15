import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/employee/chat/model/chat_message_model.dart';
import 'package:hollyb1213/features/employee/chat/screen/message_service.dart';
import 'package:hollyb1213/features/employee/chat/service/chat_service.dart';

class ChatController extends GetxController {
  final String conversationId;
  final String recipientId;

  ChatController({required this.conversationId, required this.recipientId});

  // Services
  final MessageService _messageService = MessageService();
  final ChatService _chatService = ChatService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  // Controllers
  final textController = TextEditingController();
  final scrollController = ScrollController();

  // State
  var messages = <ChatMessage>[].obs;
  var isLoading = true.obs;
  String? currentUserId;

  @override
  void onInit() {
    super.onInit();
    _initChat();
  }

  @override
  void onClose() {
    _chatService.disconnect();
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> _initChat() async {
    try {
      isLoading.value = true;
      currentUserId = await _prefs.getUserId();

      // 1. Fetch initial conversation history via REST API
      await _fetchConversationHistory();

      // 2. Connect to Socket.IO for real-time updates
      final token = await _prefs.getAccessToken();
      if (token == null || token.isEmpty) {
        log("Token not found. Cannot connect chat socket.");
        return; // No real-time connection without a token
      }
      _connectToSocket(token);

    } catch (e) {
      log("Error initializing chat: $e");
      // Optionally, show a user-facing error message
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchConversationHistory() async {
    try {
      final conversationData = await _messageService.getConversation(conversationId);
      final fetchedMessages = conversationData.messages.map((msg) {
        String status = 'SENT';
        if (msg.sender.id == currentUserId) {
          try {
            final statusData = msg.statuses.firstWhere((s) => s.userId == recipientId);
            status = statusData.status;
          } catch (_) {}
        }

        return ChatMessage(
          message: msg.content,
          time: msg.createdAt.toIso8601String(),
          isSentByMe: msg.sender.id == currentUserId,
          status: status,
        );
      }).toList();
      messages.assignAll(fetchedMessages.reversed); // API returns oldest first
      _scrollToBottom(jump: true);
    } catch (e) {
      log("Error fetching conversation history: $e");
      // Handle error, maybe show a snackbar
    }
  }

  void _connectToSocket(String token) {
    _chatService.connect(token, onConnect: () {
      log("Socket connected for real-time messages.");
    });

    _chatService.listenNewMessage((data) {
      if (data['conversationId'] != conversationId) return;

      final senderId = data['sender']?['id'] as String?;
      final newMessage = ChatMessage(
        message: data["content"] ?? "",
        isSentByMe: senderId != null && senderId == currentUserId,
        time: data["createdAt"] ?? "",
        status: data["status"] ?? 'SENT',
      );
      messages.insert(0, newMessage);
      _scrollToBottom();
    });
  }

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    _chatService.sendMessage(recipientId, text);
    textController.clear();
  }

  void _scrollToBottom({bool jump = false}) {
    // Wait for the UI to be built before scrolling
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        final position = scrollController.position.minScrollExtent;
        if (jump) {
          scrollController.jumpTo(position);
        } else {
          scrollController.animateTo(
            position,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      }
    });
  }
}
