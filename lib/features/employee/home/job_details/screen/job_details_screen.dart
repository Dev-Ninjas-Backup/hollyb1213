import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_back_button.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_button.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import '../controller/job_details_controller.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobDetailsController());
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Appcolor.primaryColor),
                const SizedBox(height: 20),
                Text("Loading job details .....",
                    style: getBodyTextStyle(color: Colors.grey.shade600)),
              ],
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomBackButton(),
                    ),
                    Center(
                      child: Text(
                        "Job Details",
                        style: getTextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w600,
                          color: Appcolor.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset(Imagepath.image4, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.title,
                          style: getBodyTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          controller.payRate,
                          style: getTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    Text(
                      controller.company,
                      style: getBodyTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    SizedBox(height: 14),

                    Row(
                      children: [
                        Icon(Icons.location_on, size: 18, color: Colors.grey),
                        SizedBox(width: 6),
                        Expanded(child: Text(controller.location)),
                      ],
                    ),

                    SizedBox(height: 10),

                    // --- Date ---
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 16, color: Colors.grey),
                        SizedBox(width: 6),
                        Text('Start: ${controller.startDate}'),
                        SizedBox(width: 12),
                        Text('End: ${controller.endDate}'),
                      ],
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: Colors.grey),
                        SizedBox(width: 6),
                        Text(controller.workTime),
                      ],
                    ),

                    SizedBox(height: 14),

                    // --- About Job ---
                    Text(
                      'About this job',
                      style: getBodyTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(controller.about),

                    SizedBox(height: 12),

                    // --- Responsibilities ---
                    Text(
                      'Your responsibilities',
                      style: getBodyTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    ...controller.responsibilities.map(
                      (item) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("• ", style: TextStyle(fontSize: 16)),
                          Expanded(child: Text(item)),
                        ],
                      ),
                    ),

                    SizedBox(height: 12),

                    Text(
                      'Requirements',
                      style: getBodyTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 6),
                    ...controller.requirements.map(
                      (req) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("• ", style: TextStyle(fontSize: 16)),
                          Expanded(child: Text(req)),
                        ],
                      ),
                    ),

                    SizedBox(height: 12),

                    Text(
                      'Additional details',
                      style: getBodyTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    ...controller.additionalDetails.map(
                      (req) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("• ", style: TextStyle(fontSize: 16)),
                          Expanded(child: Text(req)),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // --- Apply Button ---
                    CustomButton(buttonText: "Apply Now", onTap: () {}),
                    SizedBox(height: 70),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
