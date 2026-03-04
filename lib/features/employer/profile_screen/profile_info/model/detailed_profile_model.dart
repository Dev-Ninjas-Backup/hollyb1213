class DetailedProfileResponse {
  final bool success;
  final int statusCode;
  final String message;
  final DetailedProfileData data;
  final String timestamp;
  final String path;

  DetailedProfileResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.timestamp,
    required this.path,
  });

  factory DetailedProfileResponse.fromJson(Map<String, dynamic> json) {
    return DetailedProfileResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: DetailedProfileData.fromJson(json['data'] ?? {}),
      timestamp: json['timestamp'] ?? '',
      path: json['path'] ?? '',
    );
  }
}

class DetailedProfileData {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final DetailedProfile? profile;

  DetailedProfileData({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    this.profile,
  });

  factory DetailedProfileData.fromJson(Map<String, dynamic> json) {
    return DetailedProfileData(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? json['fullName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      profile: json['profile'] != null
          ? DetailedProfile.fromJson(json['profile'])
          : null,
    );
  }
}

class DetailedProfile {
  final String? companyName;
  final String? dateOfBirth;
  final String? address;
  final int? experienceYears;
  final String? bio;
  final String? profilePhotoUrl;
  final List<String> skills;

  DetailedProfile({
    this.companyName,
    this.dateOfBirth,
    this.address,
    this.experienceYears,
    this.bio,
    this.profilePhotoUrl,
    required this.skills,
  });

  factory DetailedProfile.fromJson(Map<String, dynamic> json) {
    return DetailedProfile(
      companyName: json['companyName'],
      dateOfBirth: json['dateOfBirth'],
      address: json['address'],
      experienceYears: json['experienceYears'],
      bio: json['bio'],
      profilePhotoUrl: json['profilePhotoUrl'],
      skills: List<String>.from(json['skills'] ?? []),
    );
  }
}
