import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_button.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/auth/login/screen/login_screen.dart';
import 'package:hollyb1213/features/auth/role_selection/controller/role_selection_controller.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(RoleSelectionController());
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundcolor,
        centerTitle: true,
        title: Text(
          "Role Selection",
          style: getTextStyle(
            color: Appcolor.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              SizedBox(height: height * 0.05),

              // Employer Box
              Obx(
                () => GestureDetector(
                  onTap: () => ctrl.selectRole('employer'),
                  child: Container(
                    width: double.infinity,
                    height: 173,
                    decoration: BoxDecoration(
                      color: Appcolor.appSecondaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: ctrl.selectedRole.value == 'employer'
                            ? Appcolor.primaryColor
                            : Appcolor.appBorderColor,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Appcolor.backgroundcolor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            Iconpath.employer,
                            width: 24,
                            height: 24,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Employer",
                          style: getTextStyle(
                            fontSize: 20,
                            color: Appcolor.appTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Employee Box
              Obx(
                () => GestureDetector(
                  onTap: () => ctrl.selectRole('employee'),
                  child: Container(
                    width: double.infinity,
                    height: 173,
                    decoration: BoxDecoration(
                      color: Appcolor.appSecondaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: ctrl.selectedRole.value == 'employee'
                            ? Appcolor.primaryColor
                            : Appcolor.appBorderColor,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Iconpath.employee, height: 53, width: 53),
                        SizedBox(height: 10),
                        Text(
                          "Employee",
                          style: getTextStyle(
                            fontSize: 20,
                            color: Appcolor.appTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.05),

              // Custom Button
              CustomButton(
                buttonText: "Continue",
                onTap: () {
                  if (ctrl.selectedRole.value.isNotEmpty) {
                   Get.offAll(() => LoginScreen());
                  } else {
                   return ;
                  }
                },
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
