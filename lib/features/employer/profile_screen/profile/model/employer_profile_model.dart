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
  final bool isNotify;
  final EmployerProfile profile;

  EmployerProfileData({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.isNotify,
    required this.profile,
  });

  factory EmployerProfileData.fromJson(Map<String, dynamic> json) {
    return EmployerProfileData(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      isNotify: json['isNotify'] ?? false,
      profile: EmployerProfile.fromJson(json['profile'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'role': role,
      'isNotify': isNotify,
      'profile': profile.toJson(),
    };
  }
}

class EmployerProfile {
  final String? companyName;
  final String address;
  final String profilePhotoUrl;

  EmployerProfile({
    this.companyName,
    required this.address,
    required this.profilePhotoUrl,
  });

  factory EmployerProfile.fromJson(Map<String, dynamic> json) {
    return EmployerProfile(
      companyName: json['companyName'],
      address: json['address'] ?? '',
      profilePhotoUrl: json['profilePhotoUrl'] ?? '',
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
