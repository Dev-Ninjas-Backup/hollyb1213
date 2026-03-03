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
  });

  /// Convert API response to JobModel
  factory JobModel.fromJson(Map<String, dynamic> json) {
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
      imageUrl: json['file'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      jobDate: json['job_date'],
      expireDate: json['expire_date'],
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
    };
  }
}
