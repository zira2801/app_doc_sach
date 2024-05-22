import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restart_app/restart_app.dart';

import '../service/auth_service.dart';

class DangXuatWidget extends StatelessWidget {
  final AuthService authService;
  const DangXuatWidget({super.key, required this.authService});

    Future<void> _restartApp() async {
    // Đợi 2 giây trước khi khởi động lại ứng dụng
    await Future.delayed(const Duration(seconds: 2));

    // Khởi động lại ứng dụng
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');}

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.amber.shade800,
      borderRadius: BorderRadius.circular(8), // Đặt borderRadius cho Material
      child: InkWell(
        onTap: () async{
          await authService.signOut();
          _restartApp();
          Restart.restartApp();// Gọi hàm restart ứng dụng sau khi đăng xuất
        },
        borderRadius: BorderRadius.circular(8), // Đặt borderRadius cho InkWell
        child: Container(
          height: 35,
          width: 190,
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: Colors.amber.shade800.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5),
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
    );;
  }
}
