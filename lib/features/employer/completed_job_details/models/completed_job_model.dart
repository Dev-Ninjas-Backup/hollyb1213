class CompletedJobModel {
  final String id;
  final String employerId;
  final String title;
  final String companyName;
  final String description;
  final List<String> jobResponsibilities;
  final List<String> requirements;
  final bool isUrgent;
  final String status;
  final String jobCategory;
  final String jobDate;
  final String expireDate;
  final String startTime;
  final String endTime;
  final String amount;
  final String totalAmount;
  final String location;
  final String? assignedEmployeeId;
  final EmployerInfo? employer;
  final String? fileUrl;
  final List<Shift> shifts;

  CompletedJobModel({
    required this.id,
    required this.employerId,
    required this.title,
    required this.companyName,
    required this.description,
    required this.jobResponsibilities,
    required this.requirements,
    required this.isUrgent,
    required this.status,
    required this.jobCategory,
    required this.jobDate,
    required this.expireDate,
    required this.startTime,
    required this.endTime,
    required this.amount,
    required this.totalAmount,
    required this.location,
    this.assignedEmployeeId,
    this.employer,
    this.fileUrl,
    required this.shifts,
  });

  factory CompletedJobModel.fromJson(Map<String, dynamic> json) {
    return CompletedJobModel(
      id: json['id'] ?? '',
      employerId: json['employer_id'] ?? '',
      title: json['title'] ?? '',
      companyName: json['company_name'] ?? '',
      description: json['description'] ?? '',
      jobResponsibilities:
          List<String>.from(json['job_responsibilities'] ?? []),
      requirements: List<String>.from(json['requirements'] ?? []),
      isUrgent: json['is_urgent'] ?? false,
      status: json['status'] ?? '',
      jobCategory: json['job_category'] ?? '',
      jobDate: json['job_date'] ?? '',
      expireDate: json['expire_date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      amount: json['amount']?.toString() ?? '0',
      totalAmount: json['totalAmount']?.toString() ?? '0',
      location: json['location'] ?? '',
      assignedEmployeeId: json['assigned_employee_id'],
      employer: json['employer'] != null
          ? EmployerInfo.fromJson(json['employer'])
          : null,
      fileUrl: json['file']?['url'],
      shifts: json['shifts'] != null
          ? List<Shift>.from(
              (json['shifts'] as List).map((shift) => Shift.fromJson(shift)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employer_id': employerId,
      'title': title,
      'company_name': companyName,
      'description': description,
      'job_responsibilities': jobResponsibilities,
      'requirements': requirements,
      'is_urgent': isUrgent,
      'status': status,
      'job_category': jobCategory,
      'job_date': jobDate,
      'expire_date': expireDate,
      'start_time': startTime,
      'end_time': endTime,
      'amount': amount,
      'totalAmount': totalAmount,
      'location': location,
      'assigned_employee_id': assignedEmployeeId,
      'employer': employer?.toJson(),
      'file': fileUrl != null ? {'url': fileUrl} : null,
      'shifts': shifts.map((shift) => shift.toJson()).toList(),
    };
  }
}

class EmployerInfo {
  final String id;
  final String? companyName;
  final int rating;
  final String? profilePhotoUrl;

  EmployerInfo({
    required this.id,
    this.companyName,
    required this.rating,
    this.profilePhotoUrl,
  });

  factory EmployerInfo.fromJson(Map<String, dynamic> json) {
    return EmployerInfo(
      id: json['id'] ?? '',
      companyName: json['company_name'],
      rating: json['rating'] ?? 0,
      profilePhotoUrl: json['profile_photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_name': companyName,
      'rating': rating,
      'profile_photo_url': profilePhotoUrl,
    };
  }
}

class Shift {
  final String id;
  final String jobId;
  final String employeeId;
  final String status;
  final String? checkedInAt;
  final String? checkedOutAt;
  final int totalWorkedSeconds;
  final String createdAt;
  final String updatedAt;

  Shift({
    required this.id,
    required this.jobId,
    required this.employeeId,
    required this.status,
    this.checkedInAt,
    this.checkedOutAt,
    required this.totalWorkedSeconds,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'] ?? '',
      jobId: json['job_id'] ?? '',
      employeeId: json['employee_id'] ?? '',
      status: json['status'] ?? '',
      checkedInAt: json['checked_in_at'],
      checkedOutAt: json['checked_out_at'],
      totalWorkedSeconds: json['total_worked_seconds'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job_id': jobId,
      'employee_id': employeeId,
      'status': status,
      'checked_in_at': checkedInAt,
      'checked_out_at': checkedOutAt,
      'total_worked_seconds': totalWorkedSeconds,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
