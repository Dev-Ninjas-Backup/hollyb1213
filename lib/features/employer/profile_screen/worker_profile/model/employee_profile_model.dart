class EmployeeProfileResponse {
  final bool success;
  final String message;
  final EmployeeProfileData data;

  EmployeeProfileResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory EmployeeProfileResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeProfileResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: EmployeeProfileData.fromJson(json['data'] ?? {}),
    );
  }
}

class EmployeeProfileData {
  final String id;
  final String userId;
  final DateTime? dateOfBirth;
  final String address;
  final int experienceYears;
  final String bio;
  final String? profilePhotoUrl;
  final double rating;
  final int totalReviews;
  final int totalJobs;
  final int totalHours;
  final String totalEarned;
  final int completedJobsCount;
  final String? latestJobTitle;
  final EmployeeUser user;
  final List<EmployeeSkill> employeeSkills;
  final List<Review> receivedReviews;

  EmployeeProfileData({
    required this.id,
    required this.userId,
    this.dateOfBirth,
    required this.address,
    required this.experienceYears,
    required this.bio,
    this.profilePhotoUrl,
    required this.rating,
    required this.totalReviews,
    required this.totalJobs,
    required this.totalHours,
    required this.totalEarned,
    required this.completedJobsCount,
    this.latestJobTitle,
    required this.user,
    required this.employeeSkills,
    required this.receivedReviews,
  });

  factory EmployeeProfileData.fromJson(Map<String, dynamic> json) {
    // Extract _count for completed jobs
    final count = json['_count'] ?? {};
    final completedJobs = count['assigned_job'] ?? 0;

    // Extract latest job title
    final assignedJobs = json['assigned_job'] as List<dynamic>?;
    final latestJobTitle = assignedJobs != null && assignedJobs.isNotEmpty
        ? assignedJobs[0]['title']
        : null;

    return EmployeeProfileData(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      address: json['address'] ?? '',
      experienceYears: json['experience_years'] ?? 0,
      bio: json['bio'] ?? '',
      profilePhotoUrl: json['profile_photo_url'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: json['total_reviews'] ?? 0,
      totalJobs: json['total_jobs'] ?? 0,
      totalHours: json['total_hours'] ?? 0,
      totalEarned: json['total_earned'] ?? '0',
      completedJobsCount: completedJobs,
      latestJobTitle: latestJobTitle,
      user: EmployeeUser.fromJson(json['user'] ?? {}),
      employeeSkills: (json['employee_skills'] as List<dynamic>?)
              ?.map((skill) => EmployeeSkill.fromJson(skill))
              .toList() ??
          [],
      receivedReviews: (json['received_reviews'] as List<dynamic>?)
              ?.map((review) => Review.fromJson(review))
              .toList() ??
          [],
    );
  }
}

class EmployeeUser {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String? phone;

  EmployeeUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    this.phone,
  });

  factory EmployeeUser.fromJson(Map<String, dynamic> json) {
    return EmployeeUser(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      phone: json['phone'],
    );
  }
}

class EmployeeSkill {
  final String id;
  final String skillId;
  final Skill skill;

  EmployeeSkill({
    required this.id,
    required this.skillId,
    required this.skill,
  });

  factory EmployeeSkill.fromJson(Map<String, dynamic> json) {
    return EmployeeSkill(
      id: json['id'] ?? '',
      skillId: json['skill_id'] ?? '',
      skill: Skill.fromJson(json['skill'] ?? {}),
    );
  }
}

class Skill {
  final String id;
  final String name;

  Skill({
    required this.id,
    required this.name,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class Review {
  final String id;
  final String jobId;
  final String employeeId;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final ReviewJob job;

  Review({
    required this.id,
    required this.jobId,
    required this.employeeId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.job,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? '',
      jobId: json['job_id'] ?? '',
      employeeId: json['employee_id'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      job: ReviewJob.fromJson(json['job'] ?? {}),
    );
  }
}

class ReviewJob {
  final String id;
  final String title;
  final String companyName;
  final String status;

  ReviewJob({
    required this.id,
    required this.title,
    required this.companyName,
    required this.status,
  });

  factory ReviewJob.fromJson(Map<String, dynamic> json) {
    return ReviewJob(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      companyName: json['company_name'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
