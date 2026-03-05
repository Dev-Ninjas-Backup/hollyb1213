class EmployerStatsResponse {
  final bool success;
  final int statusCode;
  final String message;
  final EmployerStatsData data;
  final String timestamp;
  final String path;

  EmployerStatsResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.timestamp,
    required this.path,
  });

  factory EmployerStatsResponse.fromJson(Map<String, dynamic> json) {
    return EmployerStatsResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: EmployerStatsData.fromJson(json['data'] ?? {}),
      timestamp: json['timestamp'] ?? '',
      path: json['path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data.toJson(),
      'timestamp': timestamp,
      'path': path,
    };
  }
}

class EmployerStatsData {
  final int activeJobs;
  final int completedJobs;
  final int favoriteWorkers;
  final int totalHires;

  EmployerStatsData({
    required this.activeJobs,
    required this.completedJobs,
    required this.favoriteWorkers,
    required this.totalHires,
  });

  factory EmployerStatsData.fromJson(Map<String, dynamic> json) {
    return EmployerStatsData(
      activeJobs: json['activeJobs'] ?? 0,
      completedJobs: json['completedJobs'] ?? 0,
      favoriteWorkers: json['favouriteWorkers'] ?? 0,
      totalHires: json['totalHires'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activeJobs': activeJobs,
      'completedJobs': completedJobs,
      'favoriteWorkers': favoriteWorkers,
      'totalHires': totalHires,
    };
  }
}
