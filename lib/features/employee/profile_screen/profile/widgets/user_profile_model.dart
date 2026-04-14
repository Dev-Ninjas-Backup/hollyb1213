double _parseDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

int _parseInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

class UserProfile {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final bool isNotify;
  final double rating;
  final int totalReviews;
  final ProfileDetails profile;

  UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.isNotify,
    required this.rating,
    required this.totalReviews,
    required this.profile,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    double rating = 0;
    int totalReviews = 0;

    // Extract rating and total_reviews from employee_profile
    if (json['employee_profile'] != null) {
      final employeeProfile = json['employee_profile'] as Map<String, dynamic>;
      rating = _parseDouble(employeeProfile['rating']);
      totalReviews = _parseInt(employeeProfile['total_reviews']);
    }

    final profileJson = json['employee_profile'] ?? json['profile'] ?? {};

    return UserProfile(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? 'No Name',
      email: json['email'] ?? 'No Email',
      role: json['role'] ?? '',
      isNotify: json['isNotify'] ?? false,
      rating: rating,
      totalReviews: totalReviews,
      profile: ProfileDetails.fromJson(profileJson as Map<String, dynamic>),
    );
  }
}

class ProfileDetails {
  final String? profilePhotoUrl;
  final String address;
  final int experienceYears;
  final String bio;
  final int totalJobs;
  final int totalHours;
  final double totalEarned;
  final List<String> skills;

  ProfileDetails({
    this.profilePhotoUrl,
    required this.address,
    required this.experienceYears,
    required this.bio,
    required this.totalJobs,
    required this.totalHours,
    required this.totalEarned,
    required this.skills,
  });

  factory ProfileDetails.fromJson(Map<String, dynamic> json) {
    return ProfileDetails(
      profilePhotoUrl: json['profile_photo_url'] ?? json['profilePhotoUrl'],
      address: json['address'] ?? '',
      experienceYears: json['experience_years'] ?? 0,
      bio: json['bio'] ?? '',
      totalJobs: _parseInt(json['total_jobs']),
      totalHours: _parseInt(json['total_hours']),
      totalEarned: _parseDouble(json['total_earned']),
      skills: json['employee_skills'] != null
          ? List<String>.from(json['employee_skills'])
          : json['skills'] != null
              ? List<String>.from(json['skills'])
              : [],
    );
  }
}
