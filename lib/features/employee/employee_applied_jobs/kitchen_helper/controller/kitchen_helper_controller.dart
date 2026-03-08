import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hollyb1213/features/employee/employee_applied_jobs/kitchen_helper/screen/check_in_service.dart';
import 'package:hollyb1213/features/employee/employee_applied_jobs/kitchen_helper/screen/check_out_service.dart';
import 'package:hollyb1213/features/employee/employee_applied_jobs/kitchen_helper/screen/mark_as_complete_service.dart';
import 'package:hollyb1213/features/employee/employee_applied_jobs/kitchen_helper/screen/job_details_service.dart';

class KitchenHelperController extends GetxController {
  var isCheckedIn = false.obs;
  var isCheckedOut = false.obs;
  var isCompleted = false.obs;
  var totalShiftHours = "0 hours".obs;
  var estimatedPay = "\$0.00".obs;
  var currentProgress = 0.0.obs;
  Timer? _timer;

  final CheckInService _checkInService = CheckInService();
  final CheckOutService _checkOutService = CheckOutService();
  final MarkAsCompleteService _markAsCompleteService = MarkAsCompleteService();
  final JobDetailsService _jobDetailsService = JobDetailsService();

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> checkIn(String jobId) async {
    EasyLoading.show(status: "Checking in...");
    final result = await _checkInService.checkIn(jobId);
    EasyLoading.dismiss();

    if (result['success'] == true) {
      isCheckedIn.value = true;
      currentProgress.value = 0.0;
      Get.snackbar("Success", result['message']);
      fetchJobDetails(jobId);
    } else {
      Get.snackbar("Error", result['message']);
    }
  }

  Future<void> checkOut(String jobId) async {
    EasyLoading.show(status: "Checking out...");
    final result = await _checkOutService.checkOut(jobId);
    EasyLoading.dismiss();

    if (result['success'] == true) {
      isCheckedOut.value = true;
      _timer?.cancel();
      currentProgress.value = 1.0;
      Get.snackbar("Success", result['message']);
    } else {
      Get.snackbar("Error", result['message']);
    }
  }

  Future<void> markCompleted(String jobId) async {
    EasyLoading.show(status: "Completing...");
    final result = await _markAsCompleteService.markAsComplete(jobId);
    EasyLoading.dismiss();

    if (result['success'] == true) {
      isCompleted.value = true;
      Get.snackbar("Success", result['message']);
      await fetchJobDetails(jobId);
    } else {
      Get.snackbar("Error", result['message']);
    }
  }

  Future<void> fetchJobDetails(String jobId) async {
    final result = await _jobDetailsService.getJobDetails(jobId);
    if (result['success'] == true && result['data'] != null) {
      final data = result['data'];
      if (data['start_time'] != null && data['end_time'] != null) {
        totalShiftHours.value =
            _calculateDuration(data['start_time'], data['end_time']);

        if (isCheckedIn.value && !isCheckedOut.value) {
          _startProgressTimer(data['start_time'], data['end_time']);
        }
      }
      if (data['amount'] != null) {
        estimatedPay.value = "\$${data['amount']}";
      }
    }
  }

  void _startProgressTimer(String startStr, String endStr) {
    _timer?.cancel();
    int startMinutes = _parseTimeToMinutes(startStr);
    int endMinutes = _parseTimeToMinutes(endStr);

    if (endMinutes < startMinutes) endMinutes += 24 * 60; // Handle overnight

    int totalMinutes = endMinutes - startMinutes;
    if (totalMinutes <= 0) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      int currentMinutes = now.hour * 60 + now.minute;

      // Handle overnight logic for current time
      if (currentMinutes < startMinutes && endMinutes >= 24 * 60) {
        currentMinutes += 24 * 60;
      }

      double progress = (currentMinutes - startMinutes) / totalMinutes;
      if (progress < 0.0) progress = 0.0;
      if (progress > 1.0) progress = 1.0;

      currentProgress.value = progress;
    });
  }

  String _calculateDuration(String start, String end) {
    try {
      int startMins = _parseTimeToMinutes(start);
      int endMins = _parseTimeToMinutes(end);

      if (endMins < startMins) endMins += 24 * 60; // Handle overnight

      int diff = endMins - startMins;
      int hours = diff ~/ 60;
      int minutes = diff % 60;
      return minutes > 0 ? "$hours hours $minutes mins" : "$hours hours";
    } catch (e) {
      return "N/A";
    }
  }

  int _parseTimeToMinutes(String time) {
    final parts = time.split(' ');
    final hm = parts[0].split(':');
    int h = int.parse(hm[0]);
    int m = int.parse(hm[1]);
    if (parts.length > 1) {
      if (parts[1] == 'PM' && h != 12) h += 12;
      if (parts[1] == 'AM' && h == 12) h = 0;
    }
    return h * 60 + m;
  }
}
