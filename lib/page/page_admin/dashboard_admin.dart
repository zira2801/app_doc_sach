import 'package:app_doc_sach/const/constant.dart';
import 'package:app_doc_sach/page/page_admin/main_screen.dart';
import 'package:flutter/material.dart';

class DashboardAdminWidget extends StatelessWidget{
    const DashboardAdminWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashborad Admin',
      debugShowCheckedModeBanner: false,
      // ThemeData là một lớp cung cấp thông tin về màu sắc, kiểu chữ và các yếu tố giao diện khác
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        brightness: Brightness.dark,
      ),
      home: const MainScreen(),
    );
  }

}