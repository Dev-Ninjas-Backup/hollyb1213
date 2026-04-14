

import 'package:readytowork/features/employee/home/models/latest_job_model.dart';
import 'package:readytowork/features/employee/home/models/stats_model.dart';

class LatestJobsResponse {
  final bool success;
  final String message;
  final List<LatestJob> data;
  final Stats stats;

  LatestJobsResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.stats,
  });

  factory LatestJobsResponse.fromJson(Map<String, dynamic> json) {
    var jobData = json['data'] as List;
    List<LatestJob> jobList = jobData.map((i) => LatestJob.fromJson(i)).toList();

    return LatestJobsResponse(
      success: json['success'],
      message: json['message'],
      data: jobList,
      stats: Stats.fromJson(json['stats']),
    );
  }
}
