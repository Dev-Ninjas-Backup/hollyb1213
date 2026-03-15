import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hollyb1213/features/employer/profile_screen/worker_profile/model/employee_profile_model.dart';
import 'custom_skill_container.dart';

class WorkerProfileSkills extends StatelessWidget {
  final EmployeeProfileData profile;

  const WorkerProfileSkills({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display skills in a grid
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: profile.employeeSkills.map((skill) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: (MediaQuery.of(context).size.width - 60.w) / 2,
              ),
              child: CustomSkillContainer(text: skill.skill.name),
            );
          }).toList(),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
