import 'dart:math';

import 'package:app_doc_sach/color/mycolor.dart';
import 'package:app_doc_sach/page/login_register/button/button_global.dart';
import 'package:app_doc_sach/page/login_register/dangky.dart';
import 'package:app_doc_sach/page/login_register/form/form_dangnhap/text_form.dart';
import 'package:app_doc_sach/page/login_register/service/auth_service.dart';
import 'package:app_doc_sach/page/page_admin/dashboard_admin.dart';
import 'package:app_doc_sach/widgets/dashboard_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../controller/auth_controller.dart';
import '../../view/dashboard/dashboard_screen.dart';

class DangNhapWidget extends StatefulWidget {
  const DangNhapWidget({super.key});

  @override
  State<DangNhapWidget> createState() => _DangNhapWidgetState();
}

class _DangNhapWidgetState extends State<DangNhapWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _auth = AuthService();

  // Khởi tạo một đối tượng ProgressDialog
  late ProgressDialog progressDialog;

//thay đổi kiểu dáng của thanh trạng thái để phù hợp với giao diện của ứng dụng
  void _getStatusBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));
  }

  bool _hasEmailText = false;
  bool obscurePassword = true;

  // Initialize Firebase in initState()
  @override
  void initState() {
    super.initState();
    initializeFirebase();
    progressDialog =
        ProgressDialog(context); // Khởi tạo ProgressDialog với context
    progressDialog.style(
        message: 'Đang đăng nhập...'); // Thiết lập thông điệp hiển thị

    emailController.addListener(_updateHasEmailTextValue);
    obscurePassword = true;
  }

  void clearEmail() {
    emailController.clear(); // Xóa văn bản trong email
  }

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword =
          !obscurePassword; // Thay đổi trạng thái hiển thị/ẩn mật khẩu
    });
  }

  // Function to initialize Firebase
  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
  }

  void _updateHasEmailTextValue() {
    setState(() {
      _hasEmailText = emailController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  final AuthController authController = AuthController.instance;
  @override
  Widget build(BuildContext context) {
    //WillPopScope là một widget trong Flutter cho phép bạn can thiệp và
    ///xử lý sự kiện khi người dùng nhấn nút "back" (trở về) trên thiết bị.
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
                      child: const Icon(
                        Icons.arrow_back_sharp,
                        size: 30,
                        color: Colors.black,
                      )),
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      height: 80,
                      width: 80,
                      child: const Image(
                          image: AssetImage('assets/icon/logoapp.png')),
                    ),
                  ),

                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      color: MyColor.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  // Email Input
                  TextFormGlobal(
                    controller: emailController,
                    text: 'Email',
                    obscure: false,
                    textInputType: TextInputType.emailAddress,
                    icon: const Icon(Icons.email_outlined),
                    suffixIcon: _hasEmailText
                        ? IconButton(
                            icon:
                                Icon(Icons.clear, color: Colors.grey.shade700),
                            onPressed: clearEmail,
                          )
                        : null,
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  // Password Input
                  TextFormGlobal(
                    controller: passwordController,
                    text: 'Password',
                    obscure: obscurePassword,
                    textInputType: TextInputType.text,
                    icon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey.shade700,
                      ),
                      onPressed:
                          togglePasswordVisibility, // Gọi hàm togglePasswordVisibility khi nhấn vào IconButton
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
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
                  const SizedBox(
                    height: 30,
                  ),
                  ButtonGlobal(
                    text: 'Đăng nhập',
                    onPressed: () {
                      _login();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

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
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 300),
                                  transitionsBuilder: (
                                    BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation,
                                    Widget child,
                                  ) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1.0, 0.0),
                                        // Bắt đầu từ bên phải
                                        end: Offset
                                            .zero, // Kết thúc tại vị trí ban đầu
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
                                  color: MyColor.primaryColor, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) // Thêm khoảng cách giữa form và bottom navigation bar
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Thông báo yêu cầu điền thông tin đầy đủ
  _errorNullMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        padding: const EdgeInsets.all(8),
        height: 80,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 179, 89, 89),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: const Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Opps. An Error Occured",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                Spacer(),
                Text(
                  'Vui lòng điền đầy đủ thông tin.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ))
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  // Thông báo Email không hợp lệ
  _errorEmailMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        padding: const EdgeInsets.all(8),
        height: 90,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 179, 89, 89),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: const Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Opps. An Error Occured",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                Spacer(),
                Text(
                  'Email không hợp lệ. Vui lòng kiểm tra lại.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ))
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

// Thông báo Mật khẩu không hợp lệ
  _errorMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        padding: const EdgeInsets.all(8),
        height: 110,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 179, 89, 89),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: const Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Opps. An Error Occured",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                Spacer(),
                Text(
                  'Tài khoản hoặc mật khẩu không đúng,'
                  ' Không thể Đăng nhập!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ))
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  bool _isEmailValid(String email) {
    // Biểu thức chính quy để kiểm tra email
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    return emailRegex.hasMatch(email);
  }

  _login() async {
    // Kiểm tra trường nhập liệu không được trống
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _errorNullMessage(context);
      return;
    }
    // Kiểm tra email có hợp lệ không
    if (!_isEmailValid(emailController.text)) {
      _errorEmailMessage(context);
      return;
    }
    try {
      authController.signIn(email: emailController.text, password: passwordController.text, context: context);
    }on FirebaseAuthException catch (e) {
      progressDialog.hide();
      if (e.code == 'user-not-found') {
        _errorMessage(context);
      } else if (e.code == 'wrong-password') {
        _errorMessage(context);
      } else {
        _errorMessage(context);
      }
    } catch (e) {
      /*progressDialog.hide();*/
      _errorMessage(context);
    }
  }
}
