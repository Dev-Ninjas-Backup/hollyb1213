import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:readytowork/core/common/constants/api_endpoint.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';
import 'dart:convert';

import 'package:readytowork/features/employer/favorite_workers/model/favorite_employees_model.dart'
    as fav;
import 'package:readytowork/features/employer/profile_screen/review/model/all_reviews_model.dart'
    as rev;

class AllReviewsController extends GetxController {
  final reviews = <rev.ReviewItem>[].obs;
  final paginationInfo = Rx<rev.PaginationInfo?>(null);
  final isLoading = true.obs;
  final error = ''.obs;
  final currentPage = 1.obs;
  final itemsPerPage = 10;

  late String employeeId;

  void setEmployeeId(String id) {
    employeeId = id;
  }

  Future<void> fetchAllReviews({bool isRefresh = true}) async {
    try {
      if (isRefresh) {
        currentPage.value = 1;
        isLoading.value = true;
      }

      final accessToken = await SharedPreferenceHelper().getAccessToken();
      if (accessToken == null) {
        error.value = 'Access token not found';
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(
          ApiEndpoint.seeAllReviews(
              employeeId, currentPage.value, itemsPerPage),
        ),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          final allReviewsResponse =
              rev.AllReviewsResponse.fromJson(jsonResponse);

          if (isRefresh) {
            reviews.clear();
            reviews.addAll(allReviewsResponse.data);
          } else {
            reviews.addAll(allReviewsResponse.data);
          }

          paginationInfo.value = allReviewsResponse.paginationInfo;
          error.value = '';
        } else {
          error.value = jsonResponse['message'] ?? 'Failed to fetch reviews';
          Get.snackbar('Error', error.value);
        }
      } else {
        error.value = 'Failed to load reviews';
        Get.snackbar('Error', error.value);
      }
    } catch (e) {
      error.value = 'Error: $e';
      Get.snackbar('Error', 'Error loading reviews: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (paginationInfo.value != null &&
        currentPage.value < paginationInfo.value!.totalPages) {
      currentPage.value++;
      await fetchAllReviews(isRefresh: false);
    }
  }

  double getAverageRating() {
    if (reviews.isEmpty) return 0.0;
    final sum = reviews.fold<double>(0, (sum, review) => sum + review.rating);
    return sum / reviews.length;
  }

  Map<String, int> getRatingCounts() {
    final counts = {
      '5': 0,
      '4': 0,
      '3': 0,
      '2': 0,
      '1': 0,
    };

    for (var review in reviews) {
      counts[review.rating.toString()] =
          (counts[review.rating.toString()] ?? 0) + 1;
    }

    return counts;
  }
}
