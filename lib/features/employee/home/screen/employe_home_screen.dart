import 'package:flutter/material.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';

class EmployeHomeScreen extends StatelessWidget {
  const EmployeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: Center(child: Text('Employe Home Screen')),
    );
  }
}
