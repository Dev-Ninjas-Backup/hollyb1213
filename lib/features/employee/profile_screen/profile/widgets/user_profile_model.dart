class UserProfile {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final bool isNotify;
  final ProfileDetails profile;

  UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.isNotify,
    required this.profile,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? 'No Name',
      email: json['email'] ?? 'No Email',
      role: json['role'] ?? '',
      isNotify: json['isNotify'] ?? false,
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
