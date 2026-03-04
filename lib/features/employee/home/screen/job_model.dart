class Job {
  final String id;
  final String title;
  final String companyName;
  final String description;
  final List<String> requirements;
  final String jobCategory;
  final bool isUrgent;
  final String jobDate;
  final String startTime;
  final String endTime;
  final String amount;
  final String totalAmount;
  final String location;
  final String createdAt;
  final String? fileUrl;

  Job({
    required this.id,
    required this.title,
    required this.companyName,
    required this.description,
    required this.requirements,
    required this.jobCategory,
    required this.isUrgent,
    required this.jobDate,
    required this.startTime,
    required this.endTime,
    required this.amount,
    required this.totalAmount,
    required this.location,
    required this.createdAt,
    this.fileUrl,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] ?? '',
      title: json['title'] ?? 'No Title',
      companyName: json['company_name'] ?? 'No Company',
      description: json['description'] ?? '',
      requirements: json['requirements'] != null
          ? List<String>.from(json['requirements'])
          : [],
      jobCategory: json['job_category'] ?? '',
      isUrgent: json['is_urgent'] ?? false,
      jobDate: json['job_date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      amount: json['amount']?.toString() ?? '0',
      totalAmount: json['totalAmount']?.toString() ?? '0',
      location: json['location'] ?? 'No Location',
      createdAt: json['created_at'] ?? '',
      fileUrl: json['file']?['url'],
    );
  }
}
