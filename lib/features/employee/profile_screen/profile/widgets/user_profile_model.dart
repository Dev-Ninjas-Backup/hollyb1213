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
      rating = (employeeProfile['rating'] ?? 0).toDouble();
      totalReviews = employeeProfile['total_reviews'] ?? 0;
    }

    return UserProfile(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? 'No Name',
      email: json['email'] ?? 'No Email',
      role: json['role'] ?? '',
      isNotify: json['isNotify'] ?? false,
      rating: rating,
      totalReviews: totalReviews,
      profile: ProfileDetails.fromJson(json['profile'] ?? {}),
    );
  }
}

class ProfileDetails {
  final String? profilePhotoUrl;
  final List<String> skills;

  ProfileDetails({
    this.profilePhotoUrl,
    required this.skills,
  });

  factory ProfileDetails.fromJson(Map<String, dynamic> json) {
    return ProfileDetails(
      profilePhotoUrl: json['profilePhotoUrl'],
      skills: json['skills'] != null ? List<String>.from(json['skills']) : [],
    );
  }
}
