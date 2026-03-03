class LatestJob {
  final String id;
  final String title;
  final String companyName;
  final String description;
  final List<String> requirements;
  final String jobCategory;
  final bool isUrgent;
  final DateTime jobDate;
  final String startTime;
  final String endTime;
  final String amount;
  final String totalAmount;
  final String location;
  final DateTime createdAt;
  final File? file;

  LatestJob({
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
    this.file,
  });

  factory LatestJob.fromJson(Map<String, dynamic> json) {
    return LatestJob(
      id: json['id'],
      title: json['title'],
      companyName: json['company_name'],
      description: json['description'],
      requirements: List<String>.from(json['requirements']),
      jobCategory: json['job_category'],
      isUrgent: json['is_urgent'],
      jobDate: DateTime.parse(json['job_date']),
      startTime: json['start_time'],
      endTime: json['end_time'],
      amount: json['amount'],
      totalAmount: json['totalAmount'],
      location: json['location'],
      createdAt: DateTime.parse(json['created_at']),
      file: json['file'] != null ? File.fromJson(json['file']) : null,
    );
  }
}

class File {
  final String url;

  File({required this.url});

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      url: json['url'],
    );
  }
}
