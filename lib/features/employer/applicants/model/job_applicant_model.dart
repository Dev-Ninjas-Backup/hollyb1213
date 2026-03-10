class JobApplicantModel {
  final String id;
  final String title;
  final String companyName;
  final bool isUrgent;
  final String status;
  final DateTime jobDate;
  final DateTime expireDate;
  final JobFileModel? file;
  final String? assignedEmployeeId;
  final ReviewModel? review;
  final String startTime;
  final String endTime;
  final String amount;
  final String totalAmount;
  final String location;
  final JobCountModel count;
  final DateTime updatedAt;

  JobApplicantModel({
    required this.id,
    required this.title,
    required this.companyName,
    required this.isUrgent,
    required this.status,
    required this.jobDate,
    required this.expireDate,
    required this.file,
    this.assignedEmployeeId,
    this.review,
    required this.startTime,
    required this.endTime,
    required this.amount,
    required this.totalAmount,
    required this.location,
    required this.count,
    required this.updatedAt,
  });

  factory JobApplicantModel.fromJson(Map<String, dynamic> json) {
    return JobApplicantModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      companyName: json['company_name'] ?? '',
      isUrgent: json['is_urgent'] ?? false,
      status: json['status'] ?? 'open',
      jobDate: json['job_date'] != null
          ? DateTime.parse(json['job_date'])
          : DateTime.now(),
      expireDate: json['expire_date'] != null
          ? DateTime.parse(json['expire_date'])
          : DateTime.now(),
      file: json['file'] != null ? JobFileModel.fromJson(json['file']) : null,
      assignedEmployeeId: json['assigned_employee_id'],
      review:
          json['review'] != null ? ReviewModel.fromJson(json['review']) : null,
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      amount: json['amount'] ?? '0',
      totalAmount: json['totalAmount'] ?? '0',
      location: json['location'] ?? '',
      count: json['_count'] != null
          ? JobCountModel.fromJson(json['_count'])
          : JobCountModel(jobApplications: 0),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company_name': companyName,
      'is_urgent': isUrgent,
      'status': status,
      'job_date': jobDate.toIso8601String(),
      'expire_date': expireDate.toIso8601String(),
      'file': file?.toJson(),
      'assigned_employee_id': assignedEmployeeId,
      'review': review?.toJson(),
      'start_time': startTime,
      'end_time': endTime,
      'amount': amount,
      'totalAmount': totalAmount,
      'location': location,
      '_count': count.toJson(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class JobFileModel {
  final String url;

  JobFileModel({
    required this.url,
  });

  factory JobFileModel.fromJson(Map<String, dynamic> json) {
    return JobFileModel(
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}

class JobCountModel {
  final int jobApplications;

  JobCountModel({
    required this.jobApplications,
  });

  factory JobCountModel.fromJson(Map<String, dynamic> json) {
    return JobCountModel(
      jobApplications: json['job_applications'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_applications': jobApplications,
    };
  }
}

class ReviewModel {
  final String id;
  final int rating;

  ReviewModel({
    required this.id,
    required this.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      rating: json['rating'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
    };
  }
}
