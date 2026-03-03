// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:hollyb1213/core/common/style/global_text_style.dart';
// import 'package:hollyb1213/features/employer/create_post/controller/create_post_controller.dart';

// class DropDownField extends StatelessWidget {
//   const DropDownField({super.key, required this.controller});

//   final CreatePostController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 16.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Job Type",
//             style: getBodyTextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 16.sp,
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 12.w),
//             decoration: BoxDecoration(
//               color: Colors.grey[50],
//               borderRadius: BorderRadius.circular(12.r),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: Obx(
//               () => DropdownButton<String>(
//                 value: controller.jobTypeController.text.isEmpty
//                     ? null
//                     : controller.jobTypeController.text,
//                 hint: Text("Select Job Type"),
//                 isExpanded: true,
//                 underline: SizedBox(),
//                 items: controller.jobTypes
//                     .map(
//                       (type) =>
//                           DropdownMenuItem(value: type, child: Text(type)),
//                     )
//                     .toList(),
//                 onChanged: (value) {
//                   if (value != null) {
//                     controller.jobTypeController.text = value;
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
