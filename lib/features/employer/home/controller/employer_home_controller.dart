import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';

class EmployerHomeController extends GetxController {
  // Header
  final headerTitle = "Need a Worker Today ?".obs;
  final headerSubtitle =
      "Post your job and find verified workers instantly.".obs;

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
