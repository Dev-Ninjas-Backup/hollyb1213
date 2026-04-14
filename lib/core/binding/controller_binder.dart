import 'package:get/instance_manager.dart';
import 'package:readytowork/features/auth/role_selection/controller/role_selection_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(RoleSelectionController(), permanent: true);
  }
}
