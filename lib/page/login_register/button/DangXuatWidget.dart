import 'package:app_doc_sach/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restart_app/restart_app.dart';

import '../service/auth_service.dart';

class DangXuatWidget extends StatefulWidget {
  const DangXuatWidget({super.key});

  @override
  State<DangXuatWidget> createState() => _DangXuatWidgetState();
}

class _DangXuatWidgetState extends State<DangXuatWidget> {
  Future<void> _restartApp() async {
    // Đợi 2 giây trước khi khởi động lại ứng dụng
    await Future.delayed(const Duration(seconds: 2));

    // Khởi động lại ứng dụng
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Đăng xuất"),
          content: const Text("Bạn có chắc muốn đăng xuất?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Hủy"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Đồng ý"),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                authController.signOut();
                setState(() {});
                Restart
                    .restartApp(); // Gọi hàm restart ứng dụng sau khi đăng xuất
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            authController.user.value!.fullName,
            style: const TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            // Đặt borderRadius cho Material
            child: InkWell(
              onTap: _showLogoutConfirmationDialog,
              // Show the confirmation dialog
              borderRadius: BorderRadius.circular(8),
              // Đặt borderRadius cho InkWell
              child: Container(
                height: 35,
                width: 190,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.amber.shade800,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Màu của bóng
                      spreadRadius: 1, // Độ lan của bóng
                      blurRadius: 4, // Độ mờ của bóng
                      offset: Offset(0, 2), // Vị trí của bóng (x,y)
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Đăng xuất',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}