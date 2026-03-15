import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';
import 'package:hollyb1213/features/employee/jobs/model/job_model.dart';

class JobController extends GetxController {
  var jobs = <JobModel>[].obs;
  var selectedCategory = 'All'.obs;
  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    jobs.addAll([
      JobModel(
        title: 'Delivery Driver',
        category: 'Delivery',
        location: 'Dhaka',
        pay: '\$50/day',
        imageUrl: Imagepath.rectangle1,
        isUrgent: true,
      ),
      JobModel(
        title: 'Restaurant Chef',
        category: 'Restaurant',
        location: 'Chittagong',
        pay: '\$80/day',
        imageUrl: Imagepath.rectangle1,
      ),
      JobModel(
        title: 'Software Engineer',
        category: 'High Pay',
        location: 'Remote',
        pay: '\$1200/month',
        imageUrl: Imagepath.rectangle1,
      ),
      JobModel(
        title: 'Nearby Courier',
        category: 'Nearby',
        location: 'Dhaka',
        pay: '\$40/day',
        imageUrl: Imagepath.rectangle1,
      ),
      JobModel(
        title: 'Urgent Helper',
        category: 'Urgent',
        location: 'Sylhet',
        pay: '\$60/day',
        imageUrl: Imagepath.rectangle1,
        isUrgent: true,
      ),
    ]);
  }

  List<JobModel> get filteredJobs {
    var filtered = jobs.toList();
    if (selectedCategory.value != 'All') {
      filtered = filtered
          .where((job) => job.category == selectedCategory.value)
          .toList();
    }
    if (searchText.value.isNotEmpty) {
      filtered = filtered
          .where(
            (job) => job.title.toLowerCase().contains(
              searchText.value.toLowerCase(),
            ),
          )
          .toList();
    }
    return filtered;
  }
}
