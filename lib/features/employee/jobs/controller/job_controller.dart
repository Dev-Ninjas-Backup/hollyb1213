import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/imagepath.dart';
import 'package:readytowork/features/employer/jobs/models/job_model.dart';

class JobController extends GetxController {
  var jobs = <JobModel>[].obs;
  var selectedCategory = 'All'.obs;
  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    jobs.addAll([
      JobModel(
        id: '1',
        title: 'Delivery Driver',
        subtitle: 'Delivery',
        location: 'Dhaka',
        companyName: 'FoodPanda',
        amount: '50',
        applicants: 5,
        status: 'open',
        imageUrl: Imagepath.rectangle1,
        isUrgent: true,
      ),
      JobModel(
        id: '2',
        title: 'Restaurant Chef',
        subtitle: 'Restaurant',
        location: 'Chittagong',
        companyName: 'Tasty Treat',
        amount: '80',
        applicants: 2,
        status: 'open',
        imageUrl: Imagepath.rectangle1,
        isUrgent: false,
      ),
      JobModel(
        id: '3',
        title: 'Software Engineer',
        subtitle: 'High Pay',
        location: 'Remote',
        companyName: 'Tech Corp',
        amount: '1200',
        applicants: 10,
        status: 'open',
        imageUrl: Imagepath.rectangle1,
        isUrgent: false,
      ),
      JobModel(
        id: '4',
        title: 'Nearby Courier',
        subtitle: 'Nearby',
        location: 'Dhaka',
        companyName: 'Pathao',
        amount: '40',
        applicants: 8,
        status: 'open',
        imageUrl: Imagepath.rectangle1,
        isUrgent: false,
      ),
      JobModel(
        id: '5',
        title: 'Urgent Helper',
        subtitle: 'Urgent',
        location: 'Sylhet',
        companyName: 'Event Co',
        amount: '60',
        applicants: 3,
        status: 'open',
        imageUrl: Imagepath.rectangle1,
        isUrgent: true,
      ),
    ]);
  }

  List<JobModel> get filteredJobs {
    var filtered = jobs.toList();
    if (selectedCategory.value != 'All') {
      filtered = filtered
          .where((job) => job.subtitle == selectedCategory.value)
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
