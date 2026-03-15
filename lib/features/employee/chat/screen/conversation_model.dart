class ConversationResponse {
  final ConversationData data;

  ConversationResponse({required this.data});

  factory ConversationResponse.fromJson(Map<String, dynamic> json) {
    // The actual conversation data is nested inside json['data']['data']
    // We handle potential nulls safely, though strictly the API should return data on success.
    final dataContainer = json['data'];
    final innerData = dataContainer != null ? dataContainer['data'] : null;
    
    if (innerData == null) {
      throw Exception("Invalid API Response: Missing conversation data");
    }

    return ConversationResponse(
      data: ConversationData.fromJson(innerData),
    );
  }
}

class ConversationData {
  final String conversationId;
  final Participant participant;
  final List<Participant> participants;
  final List<Message> messages;
  final Pagination pagination;

  ConversationData({
    required this.conversationId,
    required this.participant,
    required this.participants,
    required this.messages,
    required this.pagination,
  });

  factory ConversationData.fromJson(Map<String, dynamic> json) {
    return ConversationData(
      conversationId: json['conversationId'] as String,
      participant: Participant.fromJson(json['participant'] as Map<String, dynamic>),
      participants: (json['participants'] as List<dynamic>)
          .map((x) => Participant.fromJson(x as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List<dynamic>)
          .map((x) => Message.fromJson(x as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }
}

class Participant {
  final String id;
  final String fullName;
  final String email;

  Participant({
    required this.id,
    required this.fullName,
    required this.email,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
    );
  }
}

class Message {
  final String id;
  final String content;
  final String type;
  final DateTime createdAt;
  final Participant sender;
  final dynamic file;
  final bool isMine;
  final List<MessageStatus> statuses;

  Message({
    required this.id,
    required this.content,
    required this.type,
    required this.createdAt,
    required this.sender,
    this.file,
    required this.isMine,
    required this.statuses,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      content: json['content'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      sender: Participant.fromJson(json['sender'] as Map<String, dynamic>),
      file: json['file'],
      isMine: json['isMine'] as bool,
      statuses: (json['statuses'] as List<dynamic>)
          .map((x) => MessageStatus.fromJson(x as Map<String, dynamic>))
          .toList(),
    );
  }
}

class MessageStatus {
  final String userId;
  final String status;

  MessageStatus({
    required this.userId,
    required this.status,
  });

  factory MessageStatus.fromJson(Map<String, dynamic> json) {
    return MessageStatus(
      userId: json['userId'] as String,
      status: json['status'] as String,
    );
  }
}

class Pagination {
  final bool hasMore;
  final String? nextCursor;

  Pagination({
    required this.hasMore,
    this.nextCursor,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      hasMore: json['hasMore'] as bool,
      nextCursor: json['nextCursor'] as String?,
    );
  }
}