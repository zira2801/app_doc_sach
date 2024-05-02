import 'package:app_doc_sach/color/mycolor.dart';
import 'package:app_doc_sach/page/login_register/button/button_global.dart';
import 'package:app_doc_sach/page/login_register/dangky.dart';
import 'package:app_doc_sach/page/login_register/form/form_dangnhap/text_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DangNhapWidget extends StatefulWidget {
  const DangNhapWidget({super.key});

  @override
  State<DangNhapWidget> createState() => _DangNhapWidgetState();
}

class _DangNhapWidgetState extends State<DangNhapWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void  _getStatusBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,)
    );
  }

  // Initialize Firebase in initState()
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  // Function to initialize Firebase
  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Future.delayed(const Duration(milliseconds: 300), () {
          _getStatusBarStyle();
        });


        // Trả về true để cho phép pop màn hình
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            color: Colors.grey.shade50,
            height: double.infinity,
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          _getStatusBarStyle();
                        });
      
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_sharp,size: 30,color: Colors.black,)),
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      height: 80,
                      width: 80,
                      child: const Image(image: AssetImage('assets/icon/logoapp.png')),
                    ),
                  ),
                    
                  const SizedBox(height: 50,),
                  const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      color: MyColor.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                    
                  const SizedBox(height: 15,),
                  // Email Input
                  TextFormGlobal(
                    controller: emailController,
                    text: 'Email',
                    obscure: false,
                    textInputType: TextInputType.emailAddress,
                    icon: const Icon(Icons.email_outlined),
                  ),
                    
                  const SizedBox(height: 15,),
                  // Password Input
                  TextFormGlobal(
                    controller: passwordController,
                    text: 'Password',
                    obscure: true,
                    textInputType: TextInputType.text,
                    icon: const Icon(Icons.lock_outline),
                  ),
                    
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            print('kkkk');
                          },
                          child: const Text(
                            'Quên mật khẩu ?',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  const ButtonGlobal(text: 'Đăng nhập',),
                  const SizedBox(height: 20,),
                    
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 50,
                      color: Colors.grey.shade50,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Bạn chưa có tài khoản?',
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          const SizedBox(width: 5,),
                          InkWell(
                            onTap: () {
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
                                    return const DangKyWidget();
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              'Đăng ký',
                              style: TextStyle(
                                color: MyColor.primaryColor,fontSize: 13
      
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )// Thêm khoảng cách giữa form và bottom navigation bar
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }


}
