import 'package:app_doc_sach/page/login_register/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restart_app/restart_app.dart';

class TimKiemWidget extends StatefulWidget {
  const TimKiemWidget({super.key});

  @override
  State<TimKiemWidget> createState() => _TimKiemWidgetState();
}

class _TimKiemWidgetState extends State<TimKiemWidget> {

  final AuthService _auth = AuthService();
  Future<void> _restartApp() async {
  // Đợi 2 giây trước khi khởi động lại ứng dụng
  await Future.delayed(const Duration(seconds: 2));

  // Khởi động lại ứng dụng
  await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 50,
        width: 50,
        child: Center(
          child: ElevatedButton(
            onPressed: () async{
              await _auth.signOut();
              _restartApp();
              Restart.restartApp();// Gọi hàm restart ứng dụng sau khi đăng xuất
            },
            child: Text('logout'),
          ),
        ),
      ),
    );
  }
}
