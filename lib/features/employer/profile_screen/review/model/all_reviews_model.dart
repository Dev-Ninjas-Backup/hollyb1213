class AllReviewsResponse {
  final bool success;
  final String message;
  final List<ReviewItem> data;
  final PaginationInfo paginationInfo;

  AllReviewsResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.paginationInfo,
  });

  factory AllReviewsResponse.fromJson(Map<String, dynamic> json) {
    return AllReviewsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((review) => ReviewItem.fromJson(review))
              .toList() ??
          [],
      paginationInfo: PaginationInfo.fromJson(json['paginationInfo'] ?? {}),
    );
  }
}

class ReviewItem {
  final String id;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final ReviewJob job;
  final ReviewEmployee employee;

  ReviewItem({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.job,
    required this.employee,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      id: json['id'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      job: ReviewJob.fromJson(json['job'] ?? {}),
      employee: ReviewEmployee.fromJson(json['employee'] ?? {}),
    );
  }
}

class ReviewJob {
  final String id;
  final String title;
  final String companyName;
  final String status;
  final String location;

  ReviewJob({
    required this.id,
    required this.title,
    required this.companyName,
    required this.status,
    required this.location,
  });

  factory ReviewJob.fromJson(Map<String, dynamic> json) {
    return ReviewJob(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      companyName: json['company_name'] ?? '',
      status: json['status'] ?? '',
      location: json['location'] ?? '',
    );
  }
}

class ReviewEmployee {
  final String id;
  final String? profilePhotoUrl;
  final double rating;
  final int totalReviews;
  final ReviewEmployeeUser user;

  ReviewEmployee({
    required this.id,
    this.profilePhotoUrl,
    required this.rating,
    required this.totalReviews,
    required this.user,
  });

  factory ReviewEmployee.fromJson(Map<String, dynamic> json) {
    return ReviewEmployee(
      id: json['id'] ?? '',
      profilePhotoUrl: json['profile_photo_url'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: json['total_reviews'] ?? 0,
      user: ReviewEmployeeUser.fromJson(json['user'] ?? {}),
    );
  }
}

class ReviewEmployeeUser {
  final String fullName;
  final String email;

  ReviewEmployeeUser({
    required this.fullName,
    required this.email,
  });

  factory ReviewEmployeeUser.fromJson(Map<String, dynamic> json) {
    return ReviewEmployeeUser(
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class PaginationInfo {
  final int page;
  final int limit;
  final int totalReviews;
  final int totalPages;

  PaginationInfo({
    required this.page,
    required this.limit,
    required this.totalReviews,
    required this.totalPages,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      totalReviews: json['totalReviews'] ?? 0,
      totalPages: json['totalPages'] ?? 1,
    );
  }
}
