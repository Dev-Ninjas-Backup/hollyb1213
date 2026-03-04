class EmployerProfileResponse {
  final bool success;
  final int statusCode;
  final String message;
  final EmployerProfileData data;
  final String timestamp;
  final String path;

  EmployerProfileResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.timestamp,
    required this.path,
  });

  factory EmployerProfileResponse.fromJson(Map<String, dynamic> json) {
    return EmployerProfileResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: EmployerProfileData.fromJson(json['data'] ?? {}),
      timestamp: json['timestamp'] ?? '',
      path: json['path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data.toJson(),
      'timestamp': timestamp,
      'path': path,
    };
  }
}

class EmployerProfileData {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String? accountStatus;
  final bool? isActive;
  final bool? isVerified;
  final bool isNotify;
  final bool? isDeleted;
  final String? lastActiveAt;
  final String? lastLoginAt;
  final String? createdAt;
  final String? updatedAt;
  final EmployerProfileDetail? employerProfile;
  final EmployerProfile? profile;

  EmployerProfileData({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    this.accountStatus,
    this.isActive,
    this.isVerified,
    required this.isNotify,
    this.isDeleted,
    this.lastActiveAt,
    this.lastLoginAt,
    this.createdAt,
    this.updatedAt,
    this.employerProfile,
    this.profile,
  });

  factory EmployerProfileData.fromJson(Map<String, dynamic> json) {
    return EmployerProfileData(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? json['fullName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      accountStatus: json['account_status'],
      isActive: json['is_active'],
      isVerified: json['is_verified'],
      isNotify: json['isNotify'] ?? false,
      isDeleted: json['is_deleted'],
      lastActiveAt: json['last_active_at'],
      lastLoginAt: json['last_login_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      employerProfile: json['employer_profile'] != null
          ? EmployerProfileDetail.fromJson(json['employer_profile'])
          : null,
      profile: json['profile'] != null
          ? EmployerProfile.fromJson(json['profile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'role': role,
      'account_status': accountStatus,
      'is_active': isActive,
      'is_verified': isVerified,
      'isNotify': isNotify,
      'is_deleted': isDeleted,
      'last_active_at': lastActiveAt,
      'last_login_at': lastLoginAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'employer_profile': employerProfile?.toJson(),
      'profile': profile?.toJson(),
    };
  }
}

class EmployerProfileDetail {
  final String id;
  final String userId;
  final String? companyName;
  final String? address;
  final String? profilePhotoUrl;
  final double? rating;
  final int? totalReviews;
  final int? totalHires;
  final String? createdAt;
  final String? updatedAt;

  EmployerProfileDetail({
    required this.id,
    required this.userId,
    this.companyName,
    this.address,
    this.profilePhotoUrl,
    this.rating,
    this.totalReviews,
    this.totalHires,
    this.createdAt,
    this.updatedAt,
  });

  factory EmployerProfileDetail.fromJson(Map<String, dynamic> json) {
    return EmployerProfileDetail(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      companyName: json['company_name'],
      address: json['address'],
      profilePhotoUrl: json['profile_photo_url'],
      rating: (json['rating'] as num?)?.toDouble(),
      totalReviews: json['total_reviews'],
      totalHires: json['total_hires'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'company_name': companyName,
      'address': address,
      'profile_photo_url': profilePhotoUrl,
      'rating': rating,
      'total_reviews': totalReviews,
      'total_hires': totalHires,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class EmployerProfile {
  final String? companyName;
  final String? address;
  final String? profilePhotoUrl;

  EmployerProfile({
    this.companyName,
    this.address,
    this.profilePhotoUrl,
  });

  factory EmployerProfile.fromJson(Map<String, dynamic> json) {
    return EmployerProfile(
      companyName: json['companyName'],
      address: json['address'],
      profilePhotoUrl: json['profilePhotoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'address': address,
      'profilePhotoUrl': profilePhotoUrl,
    };
  }
}
