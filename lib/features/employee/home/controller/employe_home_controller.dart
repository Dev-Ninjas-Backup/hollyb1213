import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';

class EmployeHomeController extends GetxController {
  // Header
  final headerTitle = "Hi Nicolas, ready to work today?".obs;
  final headerSubtitle = "Explore nearby opportunities & activities".obs;

  final quickActions = <Map<String, dynamic>>[
    {
      "icon": Iconpath.job3,
      "title": "Available Jobs",
      "subtitle": "12 Nearby",
      "height": 40.0,
      "width": 40.0,
    },
    {
      "icon": Iconpath.job3,
      "title": "Applied Jobs",
      "subtitle": "2 Confirmed",
      "height": 40.0,
      "width": 40.0,
    },
  ].obs;

  final nearbyJobs = <Map<String, dynamic>>[
    {
      "image": Imagepath.imagefst,
      "title": "Restaurant Assistant",
      "subtitle": "Burger Palace",
      "distance": "1.2 Km away",
      "urgent": true,
    },
    {
      "image": Imagepath.image1,
      "title": "Event Coordinator",
      "subtitle": "Cultural Hall",
      "distance": "2.5 Km away",
      "urgent": false,
    },
    {
      "image": Imagepath.image2,
      "title": "Museum Guide",
      "subtitle": "Heritage Museum",
      "distance": "0.8 Km away",
      "urgent": true,
    },
  ].obs;
}
