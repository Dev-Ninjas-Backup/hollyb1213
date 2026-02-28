import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/employee/home/widgets/job_card_widget.dart';
import 'package:hollyb1213/features/employee/jobs/controller/employee_jobs_controller.dart';
import 'package:hollyb1213/routes/app_route.dart';

class JobScreen extends StatelessWidget {
  const JobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeJobsController controller =
        Get.find<EmployeeJobsController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Jobs",
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Appcolor.primaryColor,
          ),
        ),
        backgroundColor: Appcolor.backgroundcolor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      backgroundColor: Appcolor.backgroundcolor,
      body: Obx(() {
        if (controller.isLoading.value && controller.jobsList.isEmpty) {
          return Center(
            child: CircularProgressIndicator(color: Appcolor.primaryColor),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.getJobs(),
          child: controller.jobsList.isEmpty
              ? SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No jobs available at the moment.",
                            style: getBodyTextStyle(),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Pull down to refresh",
                            style: getBodyTextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  itemCount: controller.jobsList.length,
                  itemBuilder: (context, index) {
                    final job = controller.jobsList[index];
                    // NOTE: It's highly recommended to create a Job model class
                    // to parse this map and avoid using strings for keys.
                    return JobCard(
                      image: job['file'] ?? '',
                      title: job['title'] ?? 'No Title',
                      subtitle: job['company_name'] ?? 'No Company',
                      distance: job['location'] ?? 'No Location',
                      urgent: job['is_urgent'] ?? false,
                      payRate: "\$${job['amount'] ?? '0'}",
                      buttonText: "Apply Now",
                      onPressed: () {
                        final jobId = job['id'];
                        if (jobId != null) {
                          Get.toNamed(AppRoute.getjobDetailsScreen(),
                              arguments: jobId);
                        } else {
                          Get.snackbar('Error', 'Unable to open job details.');
                        }
                      },
                    );
                  },
                ),
        );
      }),
    );
  }
}
