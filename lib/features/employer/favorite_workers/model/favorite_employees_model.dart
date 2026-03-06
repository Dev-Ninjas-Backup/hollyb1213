class FavoriteEmployeesResponse {
  final bool success;
  final String message;
  final List<FavoriteEmployee> data;
  final PaginationInfo paginationInfo;
  final int statusCode;

  FavoriteEmployeesResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.paginationInfo,
    required this.statusCode,
  });

  factory FavoriteEmployeesResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteEmployeesResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<FavoriteEmployee>.from(
              json['data'].map((item) => FavoriteEmployee.fromJson(item)))
          : [],
      paginationInfo: json['paginationInfo'] != null
          ? PaginationInfo.fromJson(json['paginationInfo'])
          : PaginationInfo(
              page: 1, limit: 10, totalFavorites: 0, totalPages: 0),
      statusCode: json['statusCode'] ?? 0,
    );
  }
}

class FavoriteEmployee {
  final String id;
  final String employerId;
  final String employeeId;
  final String createdAt;
  final Employee employee;

  FavoriteEmployee({
    required this.id,
    required this.employerId,
    required this.employeeId,
    required this.createdAt,
    required this.employee,
  });

  factory FavoriteEmployee.fromJson(Map<String, dynamic> json) {
    return FavoriteEmployee(
      id: json['id'] ?? '',
      employerId: json['employer_id'] ?? '',
      employeeId: json['employee_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      employee: json['employee'] != null
          ? Employee.fromJson(json['employee'])
          : Employee(
              id: '',
              userId: '',
              fullName: 'Unknown',
              email: '',
              profilePhotoUrl: null,
              rating: 0,
              totalReviews: 0,
              totalJobs: 0,
            ),
    );
  }
}

class Employee {
  final String id;
  final String userId;
  final String fullName;
  final String email;
  final String? profilePhotoUrl;
  final double rating;
  final int totalReviews;
  final int totalJobs;
  final String? bio;
  final int? experienceYears;

  Employee({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.email,
    this.profilePhotoUrl,
    required this.rating,
    required this.totalReviews,
    required this.totalJobs,
    this.bio,
    this.experienceYears,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      fullName: json['user']?['full_name'] ?? 'Unknown',
      email: json['user']?['email'] ?? '',
      profilePhotoUrl: json['profile_photo_url'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: json['total_reviews'] ?? 0,
      totalJobs: json['total_jobs'] ?? 0,
      bio: json['bio'],
      experienceYears: json['experience_years'],
    );
  }
}

class PaginationInfo {
  final int page;
  final int limit;
  final int totalFavorites;
  final int totalPages;

  PaginationInfo({
    required this.page,
    required this.limit,
    required this.totalFavorites,
    required this.totalPages,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      totalFavorites: json['totalFavorites'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }
}
