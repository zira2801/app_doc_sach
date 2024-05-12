import 'package:app_doc_sach/page/login_register/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimKiemWidget extends StatefulWidget {
  const TimKiemWidget({super.key});

  @override
  State<TimKiemWidget> createState() => _TimKiemWidgetState();
}

class _TimKiemWidgetState extends State<TimKiemWidget> {

  final AuthService _auth = AuthService();
  Future<void> _restartApp() async {
    // Delay 2 giây trước khi tắt ứng dụng và khởi động lại
    await Future.delayed(Duration(seconds: 2));
    // Gọi phương thức restart của hệ điều hành
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
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
              _restartApp(); // Gọi hàm restart ứng dụng sau khi đăng xuất
            },
            child: Text('logout'),
          ),
        ),
      ),
    );
  }
}
