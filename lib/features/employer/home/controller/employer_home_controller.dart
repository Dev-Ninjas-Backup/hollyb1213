import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';

class EmployerHomeController extends GetxController {
  // Header (untouched)
  final headerTitle = "Need a Worker Today ?".obs;
  final headerSubtitle =
      "Post your job and find verified workers instantly.".obs;

  // Quick Actions (untouched)
  final quickActions = <Map<String, dynamic>>[
    {
      "icon": Iconpath.applicants,
      "title": "View Applicants",
      "subtitle": "",
      "height": 40.0,
      "width": 40.0,
    },
    {
      "icon": Iconpath.favourite,
      "title": "Favourite Workers",
      "subtitle": "",
      "height": 40.0,
      "width": 40.0,
    },
  ].obs;

  // --- Category Tabs ---
  final selectedCategory = 'Active'.obs;

  // --- Active Job List ---
  final activeJobs = <Map<String, dynamic>>[
    {
      "image": Imagepath.imagefst,
      "title": "Restaurant Assistant",
      "subtitle": "Burger Palace",
      "distance": "1.2 Km away",
      "urgent": false,
      "isFavourite": false.obs,
    },
    {
      "image": Imagepath.image1,
      "title": "Event Coordinator",
      "subtitle": "Cultural Hall",
      "distance": "2.5 Km away",
      "urgent": false,
      "isFavourite": false.obs,
    },
  ].obs;

  // --- Completed Job List ---
  final completedJobs = <Map<String, dynamic>>[
    {
      "image": Imagepath.image2,
      "title": "Museum Guide",
      "subtitle": "Heritage Museum",
      "distance": "0.8 Km away",
      "urgent": false,
      "isFavourite": true.obs,
    },
    {
      "image": Imagepath.imagefst,
      "title": "Warehouse Assistant",
      "subtitle": "LogiX Depot",
      "distance": "3.4 Km away",
      "urgent": false,
      "isFavourite": false.obs,
    },
  ].obs;

  // --- Toggle between Active and Completed ---
  void setCategory(String category) {
    selectedCategory.value = category;
  }

  // --- Toggle Favourite (only for Completed Jobs) ---
  void toggleFavourite(int index) {
    if (selectedCategory.value == 'Completed') {
      final job = completedJobs[index];
      job['isFavourite'].toggle();
      completedJobs.refresh();
    }
  }

  // --- Get filtered job list ---
  RxList<Map<String, dynamic>> get filteredJobs =>
      selectedCategory.value == 'Active' ? activeJobs : completedJobs;
}
