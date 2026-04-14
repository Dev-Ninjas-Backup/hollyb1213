import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/employee/home/widgets/job_card_widget.dart';
import 'package:readytowork/features/employee/jobs/controller/employee_jobs_controller.dart';
import 'package:readytowork/routes/app_route.dart';


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
                    return JobCard(
                      image: job.fileUrl ?? '',
                      title: job.title,
                      subtitle: job.companyName,
                      distance: job.location,
                      urgent: job.isUrgent,
                      payRate: "\$${job.amount}",
                      buttonText: "Apply Now",
                      onPressed: () {
                        Get.toNamed(
                          AppRoute.getjobDetailsScreen(),
                          arguments: job.id,
                        );
                      },
                    );
                  },
                ),
        );
      }),
    );
  }
}
