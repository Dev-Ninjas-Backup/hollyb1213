import 'package:flutter/material.dart';

class JobDetailsController extends ChangeNotifier {
  final String title = "Restaurant Helper";
  final String company = "Bella Vista Restaurant";
  final String payRate = "\$18/hr";
  final String location = "1313 Downtown Street, City Center, LA 12345";
  final String startDate = "Oct 26, 2025";
  final String endDate = "Oct 30, 2025";
  final String workTime = "7:00 AM - 3:00 PM";

  final String about =
      "We are looking for a restaurant helper to assist with various kitchen and front-of-house tasks. Must be energetic, friendly, and ready to join a busy team environment. Previous experience is an asset but not required. Training provided.";

  final List<String> responsibilities = [
    "Assist chefs in basic food preparation and kitchen cleaning",
    "Bring food from the kitchen to dining areas",
    "Clean tables and arrange dining areas",
    "Assist with deliveries and storage of food",
    "Provide friendly service to guests",
  ];

  final List<String> requirements = [
    "Friendly attitude, eager to learn",
    "Able to stand for long hours (6+ hours/shift)",
    "Good communication skills",
    "Able to follow instructions and work as part of a team",
  ];

  final List<String> additionalDetails = [
    'Work Type: Same-Day Shift',
    'Posted: 6 hours ago',
  ];
}
