import 'package:app_doc_sach/controller/auth_controller.dart';

import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }

}