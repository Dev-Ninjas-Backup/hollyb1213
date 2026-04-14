class JobModel {
  final String id;
  final String title;
  final String subtitle;
  final String location;
  final String companyName;
  final String amount;
  final int applicants;
  final bool isUrgent;
  final String status; // open, assigned, completed, cancelled, closed
  final String? imageUrl;
  final String? startTime;
  final String? endTime;
  final String? jobDate;
  final String? expireDate;
  final String? assignedEmployeeId;
  final dynamic review;

  JobModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.companyName,
    required this.amount,
    required this.applicants,
    required this.isUrgent,
    required this.status,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.jobDate,
    this.expireDate,
    this.assignedEmployeeId,
    this.review,
  });

  // Getters for backward compatibility with older UI components
  String get image => imageUrl ?? 'assets/images/job_placeholder.png';
  String get company => companyName;
  String get rate => amount;
  String get time => (startTime != null && endTime != null)
      ? "$startTime - $endTime"
      : (startTime ?? "N/A");
  String get progressText => (status == 'completed') ? "100%" : "In Progress";
  String get jobDescription => subtitle;
  List<String> get requirements => []; // Placeholder if not in API

  /// Convert API response to JobModel
  factory JobModel.fromJson(Map<String, dynamic> json) {
    // Handle file which can be null, a string, or a Map with url
    String? imageUrl;
    final file = json['file'];
    if (file != null) {
      if (file is Map) {
        imageUrl = file['url'];
      } else if (file is String) {
        imageUrl = file;
      }
    }

    return JobModel(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Untitled Job',
      subtitle: json['location'] ?? 'Location not specified',
      location: json['location'] ?? '',
      companyName: json['company_name'] ?? 'Company',
      amount: json['amount']?.toString() ?? '0',
      applicants: json['_count']?['job_applications'] ?? 0,
      isUrgent: json['is_urgent'] ?? false,
      status: json['status'] ?? 'open',
      imageUrl: imageUrl,
      startTime: json['start_time'],
      endTime: json['end_time'],
      jobDate: json['job_date'],
      expireDate: json['expire_date'],
      assignedEmployeeId: json['assigned_employee_id'],
      review: json['review'],
    );
  }

  /// Convert JobModel to Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': subtitle,
      'company_name': companyName,
      'amount': amount,
      '_count': {'job_applications': applicants},
      'is_urgent': isUrgent,
      'status': status,
      'file': imageUrl,
      'start_time': startTime,
      'end_time': endTime,
      'job_date': jobDate,
      'expire_date': expireDate,
      'assigned_employee_id': assignedEmployeeId,
      'review': review,
    };
  }
}
