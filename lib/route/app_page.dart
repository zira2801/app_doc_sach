import 'package:app_doc_sach/route/app_route.dart';
import 'package:app_doc_sach/view/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';

import '../view/dashboard/dashboard_binding.dart';

class AppPage {
  static var list = [
    GetPage(
        name: AppRoute.dashboard,
        page: () => const DashBoardScreen(),
        binding: DashboardBinding()
    ),
  ];
}