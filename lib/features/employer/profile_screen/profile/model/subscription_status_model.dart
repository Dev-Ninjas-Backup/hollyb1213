class SubscriptionStatusResponse {
  final bool success;
  final int statusCode;
  final String message;
  final SubscriptionStatusData? data;

  SubscriptionStatusResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory SubscriptionStatusResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionStatusResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? SubscriptionStatusData.fromJson(json['data'])
          : null,
    );
  }
}

class SubscriptionStatusData {
  final bool hasSubscription;
  final bool hasActiveSubscription;
  final SubscriptionDetail? subscription;

  SubscriptionStatusData({
    required this.hasSubscription,
    required this.hasActiveSubscription,
    this.subscription,
  });

  factory SubscriptionStatusData.fromJson(Map<String, dynamic> json) {
    return SubscriptionStatusData(
      hasSubscription: json['hasSubscription'] ?? false,
      hasActiveSubscription: json['hasActiveSubscription'] ?? false,
      subscription: json['subscription'] != null
          ? SubscriptionDetail.fromJson(json['subscription'])
          : null,
    );
  }
}

class SubscriptionDetail {
  final String id;
  final String planType;
  final String amount;
  final String status;
  final DateTime startDate;
  final DateTime endDate;
  final bool isExpired;
  final bool isActive;
  final bool isRunning;
  final bool canRenew;

  SubscriptionDetail({
    required this.id,
    required this.planType,
    required this.amount,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.isExpired,
    required this.isActive,
    required this.isRunning,
    required this.canRenew,
  });

  factory SubscriptionDetail.fromJson(Map<String, dynamic> json) {
    return SubscriptionDetail(
      id: json['id'] ?? '',
      planType: json['planType'] ?? '',
      amount: json['amount'] ?? '0',
      status: json['status'] ?? '',
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'])
          : DateTime.now(),
      isExpired: json['isExpired'] ?? false,
      isActive: json['isActive'] ?? false,
      isRunning: json['isRunning'] ?? false,
      canRenew: json['canRenew'] ?? false,
    );
  }
}
