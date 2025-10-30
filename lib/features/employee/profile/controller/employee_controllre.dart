import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';

class EmployeeProfileControllre extends GetxController {
  final List<Map<String, dynamic>> statsList = [
    {
      "iconImage": Iconpath.jobProfileIcon,
      "count": "40",
      "completedMsg": "Jobs Completed",
    },
    {
      "iconImage": Iconpath.workIcon,
      "count": "120",
      "completedMsg": "Hours Worked",
    },
    {
      "iconImage": Iconpath.earnIcon,
      "count": "\$5.832",
      "completedMsg": "Total Earned",
    },
    {
      "iconImage": Iconpath.monthCalenderIcon,
      "count": "12",
      "completedMsg": "This Month",
    },
  ];
}
