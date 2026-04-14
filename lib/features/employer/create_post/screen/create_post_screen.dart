// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/widget/custom_back_button.dart';
import 'package:readytowork/features/employer/create_post/widgets/button_widget.dart';
import 'package:readytowork/features/employer/create_post/widgets/image_upload_section_widget.dart';
import 'package:readytowork/features/employer/create_post/widgets/job_information_widget.dart';
import 'package:readytowork/features/employer/create_post/widgets/location_section_widget.dart';
import 'package:readytowork/features/employer/create_post/widgets/payment_section_widget.dart';
import 'package:readytowork/features/employer/create_post/widgets/time_section_widget.dart';
import '../controller/create_post_controller.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreatePostController());
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Appcolor.backgroundcolor,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: CustomBackButton(),
        ),
        title: Obx(
          () => Text(
            controller.isEditMode.value ? "Edit Job" : "Create Post",
            style: TextStyle(
              color: Appcolor.primaryColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.isFetchingJobDetails.value) {
            return Center(
              child: CircularProgressIndicator(
                color: Appcolor.primaryColor,
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Job Information-----
                JobInformation(controller: controller),

                SizedBox(height: 25.h),
                // time Section-----
                TimeSection(controller: controller),
                SizedBox(height: 16.h),

                /// Payment Section
                PaymentSection(controller: controller),

                SizedBox(height: 25.h),

                /// Location Section
                LocationSection(controller: controller),

                SizedBox(height: 25.h),

                /// Image Upload Section
                ImageUploadSection(controller: controller),

                SizedBox(height: 30.h),

                /// Buttons
                SizedBox(height: 25.h),
                Button(controller: controller),
                SizedBox(height: 30.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
