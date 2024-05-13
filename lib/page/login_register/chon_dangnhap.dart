import 'dart:developer';

import 'package:app_doc_sach/page/login_register/dangnhap.dart';
import 'package:app_doc_sach/page/login_register/service/auth_service.dart';
import 'package:app_doc_sach/page/taikhoanwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../color/mycolor.dart';
import '../../provider/ui_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
class ChonDangNhapWidget extends StatefulWidget {
  const ChonDangNhapWidget({super.key});

  @override
  State<ChonDangNhapWidget> createState() => _ChonDangNhapWidgetState();
}

class _ChonDangNhapWidgetState extends State<ChonDangNhapWidget> {

  final AuthService _auth = AuthService();
  void  _getStatusBarStyle(UiProvider uiProvider) {
    if (uiProvider.isDark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,)
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ));
    }
  }

  void  _getStatusBarStyleDN() {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade400 ,Colors.amber.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  margin: const EdgeInsets.only(top: 15),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/icon/logoapp.png'),
                    radius: 55,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Read Book Online',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                ElevatedButton(
                  onPressed: () {
                    _loginGoogle();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Đặt màu nền là trong suốt
                    elevation: 0, // Loại bỏ hiệu ứng độ nâng
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.zero, // Loại bỏ padding mặc định
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient:  LinearGradient(
                        colors: [MyColor.googleColor2, Colors.blue, MyColor.googleColor],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Container(
                      width: 230,
                      height: 75,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30, left: 10),
                              child: Container(
                                width: 20,
                                height: 20,
                                child: Image.asset('assets/icon/google.png'),
                              ),
                            ),
                            const SizedBox(width: 20,),
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Column(
                                children: [
                                  Text('Đăng nhập bằng',style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  ),),
                                  Text('Google',style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Consumer <UiProvider>(
                  builder: (context,UiProvider notifier, child) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 300),
                            transitionsBuilder: (
                                BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child,
                                ) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1.0, 0.0), // Bắt đầu từ bên phải
                                  end: Offset.zero, // Kết thúc tại vị trí ban đầu
                                ).animate(animation),
                                child: child,
                              );
                            },
                            pageBuilder: (
                                BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                ) {
                              return DangNhapWidget();

                            },

                          ),
                        );
                        Future.delayed(Duration(milliseconds: 100), () {
                          _getStatusBarStyleDN();
                        });

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // Đặt màu nền là trong suốt
                        elevation: 0, // Loại bỏ hiệu ứng độ nâng
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.zero, // Loại bỏ padding mặc định
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient:  LinearGradient(
                            colors: [Colors.cyanAccent.shade700, Colors.cyanAccent.shade400],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Container(
                          width: 230,
                          height: 75,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30, left: 10),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset('assets/icon/email.png'),
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: [
                                      Text('Đăng nhập bằng',style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),),
                                      Text('Email',style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                ),
                Transform.translate(
                  offset: Offset(0, 100), // Điều chỉnh vị trí dịch chuyển xuống dưới,
                  child: Center(
                    child: Consumer <UiProvider>(
                      builder: (context,UiProvider notifier, child)  {
                        return ElevatedButton(
                          onPressed: () {
                            _getStatusBarStyle(notifier);
                            Navigator.of(context).pop();
                            // Kiểm tra điều kiện trạng thái và áp dụng kiểu thanh trạng thái tương ứng

                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.all(15), // Điều chỉnh kích thước
                            elevation: 5, // Tạo bóng với độ nâng là 5
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 20, // Điều chỉnh kích thước biểu tượng
                            color: Colors.white,
                          ),
                        );
                      }
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loginGoogle() async {
    try{
      await _auth.signInWithGoogle();
    }
    catch(e) {
      log("Error occurred: $e");
      // Ném ra ngoại lệ để bắt lỗi ở nơi gọi
      throw e;
    }
  }
}
