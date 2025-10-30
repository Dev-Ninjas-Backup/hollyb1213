import 'package:flutter/material.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_app_bar.dart';

class EmployeeProfileInfoPage extends StatelessWidget {
  const EmployeeProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          CustomAppBar(title: "Profile Info", iconUrl: Iconpath.backIcon),
        ],
      ),
    );
  }
}
