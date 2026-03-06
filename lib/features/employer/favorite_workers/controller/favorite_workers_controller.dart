import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/employer/favorite_workers/model/favorite_employees_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoriteWorkersController extends GetxController {
  // Observable lists
  final RxList<FavoriteEmployee> favoriteEmployees = <FavoriteEmployee>[].obs;
  final RxList<FavoriteEmployee> filteredEmployees = <FavoriteEmployee>[].obs;

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt pageLimit = 10.obs;
  final RxInt totalPages = 1.obs;
  final RxInt totalFavorites = 0.obs;

  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;

  // Search
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    print('[FavoriteWorkersController] onInit called');
    fetchFavoriteEmployees(page: 1);
  }

  /// Fetch favorite employees from API
  Future<void> fetchFavoriteEmployees({int page = 1}) async {
    print(
        '[FavoriteWorkersController] fetchFavoriteEmployees() started, page: $page');

    if (page == 1) {
      isLoading.value = true;
    } else {
      isLoadingMore.value = true;
    }

    try {
      final accessToken = await SharedPreferenceHelper().getAccessToken();

      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final url = ApiEndpoint.seeFavoriteEmployeeList(page, pageLimit.value);
      print('[FavoriteWorkersController] Fetching from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print(
          '[FavoriteWorkersController] Response Status: ${response.statusCode}');
      print('[FavoriteWorkersController] Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final favoritesResponse =
            FavoriteEmployeesResponse.fromJson(jsonResponse);

        if (favoritesResponse.success) {
          if (page == 1) {
            favoriteEmployees.value = favoritesResponse.data;
          } else {
            favoriteEmployees.addAll(favoritesResponse.data);
          }

          currentPage.value = favoritesResponse.paginationInfo.page;
          totalPages.value = favoritesResponse.paginationInfo.totalPages;
          totalFavorites.value =
              favoritesResponse.paginationInfo.totalFavorites;

          // Apply search filter
          _applySearchFilter();

          print(
              '[FavoriteWorkersController] Total Favorites: ${totalFavorites.value}');
          print('[FavoriteWorkersController] Total Pages: ${totalPages.value}');
        } else {
          Get.snackbar('Error', favoritesResponse.message);
        }
      } else {
        Get.snackbar('Error', 'Failed to load favorite employees');
      }
    } catch (e) {
      print('[FavoriteWorkersController] Exception: $e');
      Get.snackbar('Error', 'Error loading employees: $e');
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  /// Load more employees (pagination)
  Future<void> loadMore() async {
    if (currentPage.value < totalPages.value && !isLoadingMore.value) {
      final nextPage = currentPage.value + 1;
      await fetchFavoriteEmployees(page: nextPage);
    }
  }

  /// Search filter
  void searchEmployees(String query) {
    searchQuery.value = query;
    _applySearchFilter();
  }

  /// Apply search filter
  void _applySearchFilter() {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) {
      filteredEmployees.value = List.from(favoriteEmployees);
    } else {
      filteredEmployees.value = favoriteEmployees
          .where((employee) =>
              employee.employee.fullName.toLowerCase().contains(query))
          .toList();
    }
  }

  /// Remove employee from favorites
  Future<void> removeFavorite(String employeeId) async {
    print(
        '[FavoriteWorkersController] removeFavorite() called for: $employeeId');

    try {
      final accessToken = await SharedPreferenceHelper().getAccessToken();
      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.patch(
        Uri.parse(ApiEndpoint.removeEmployeeFromFavorites(employeeId)),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print(
          '[FavoriteWorkersController] Remove Favorite Response Status: ${response.statusCode}');
      print(
          '[FavoriteWorkersController] Remove Favorite Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Remove from local list
        favoriteEmployees
            .removeWhere((favorite) => favorite.employee.id == employeeId);
        _applySearchFilter();

        Get.snackbar('Success', 'Employee removed from favorites');
      } else {
        final jsonResponse = jsonDecode(response.body);
        final message = jsonResponse['message'] ?? 'Failed to remove favorite';
        Get.snackbar('Error', message);
      }
    } catch (e) {
      print('[FavoriteWorkersController] Exception: $e');
      Get.snackbar('Error', 'Error removing favorite: $e');
    }
  }
}
