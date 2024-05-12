import 'package:app_doc_sach/page/login_register/button/button_global_dk.dart';
import 'package:app_doc_sach/page/login_register/dangnhap.dart';
import 'package:app_doc_sach/page/login_register/service/auth_service.dart';
import 'package:app_doc_sach/view/dashboard/dashboard_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../color/mycolor.dart';
import '../../model/user_model.dart';
import 'button/button_global.dart';
import 'form/form_dangnhap/text_form.dart';

class DangKyWidget extends StatefulWidget {
  const DangKyWidget({super.key});

  @override
  State<DangKyWidget> createState() => _DangKyWidgetState();
}

class _DangKyWidgetState extends State<DangKyWidget> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  final _auth = AuthService();

  // Khởi tạo một đối tượng ProgressDialog
  late ProgressDialog progressDialog;
  bool _hasEmailText = false;
  bool obscurePassword = true;
  bool obscureRePassword = true;
  @override
  void initState() {
    super.initState();

    progressDialog =
        ProgressDialog(context); // Khởi tạo ProgressDialog với context
    progressDialog.style(
        message: 'Đang đăng ký...'); // Thiết lập thông điệp hiển thị
    emailController.addListener(_updateHasEmailTextValue);
    obscurePassword = true;
    obscureRePassword = true;
  }
  void _updateHasEmailTextValue() {
    setState(() {
      _hasEmailText = emailController.text.isNotEmpty;
    });
  }
  FocusNode? _focusedField;
  @override
  void dispose() {
    emailController.removeListener(_updateHasEmailTextValue);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void clearEmail() {
    emailController.clear(); // Xóa văn bản trong email
  }

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword; // Thay đổi trạng thái hiển thị/ẩn mật khẩu
    });
  }

  void toggleRePasswordVisibility() {
    setState(() {
      obscureRePassword = !obscureRePassword; // Thay đổi trạng thái hiển thị/ẩn mật khẩu
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      /* Future.delayed(const Duration(milliseconds: 300), () {
                        _getStatusBarStyle();
                      });
*/
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_sharp, size: 30, color: Colors.black,)),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    height: 80,
                    width: 80,
                    child: const Image(
                        image: AssetImage('assets/icon/logoapp.png')),
                  ),
                ),

                const SizedBox(height: 50,),
                const Text(
                  'Tạo tài khoản',
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
                  suffixIcon: _hasEmailText
                      ? IconButton(
                    icon: Icon(Icons.clear,color: Colors.grey.shade700),
                    onPressed: clearEmail,
                  )
                      : null,
                ),

                const SizedBox(height: 15,),
                // Password Input
                TextFormGlobal(
                  controller: passwordController,
                  text: 'Password',
                  obscure: obscurePassword,
                  textInputType: TextInputType.text,
                  icon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,color: Colors.grey.shade700,
                    ),
                    onPressed: togglePasswordVisibility, // Gọi hàm togglePasswordVisibility khi nhấn vào IconButton
                  ),
                ),

                const SizedBox(height: 15,),
                // Password Input
                TextFormGlobal(
                  controller: repasswordController,
                  text: 'Re-Password',
                  obscure: obscureRePassword,
                  textInputType: TextInputType.text,
                  icon: const Icon(Icons.lock_reset),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureRePassword ? Icons.visibility_off : Icons.visibility,color: Colors.grey.shade700
                    ),
                    onPressed: toggleRePasswordVisibility, // Gọi hàm togglePasswordVisibility khi nhấn vào IconButton
                  ),
                ),
                const SizedBox(height: 20,),
                const SizedBox(height: 30,),
                ButtonGlobal_DK(
                  text: 'Đăng ký',
                  onPressed: _handleSignUp, // Truyền hàm _dangky vào onPressed
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }


  //Đăng ký
  void _handleSignUp() async {
    // Kiểm tra trường nhập liệu không được trống
    if (emailController.text.isEmpty || passwordController.text.isEmpty || repasswordController.text.isEmpty) {
      _errorNullMessage(context);
      return;
    }
    // Kiểm tra email có hợp lệ không
    if (!_isEmailValid(emailController.text)) {
      _errorEmailMessage(context);
      return;
    }

// Kiểm tra mật khẩu có hợp lệ không
    if (!_isPasswordValid(passwordController.text)) {
      _errorPassMessage(context);
      return;
    }

// Kiểm tra mật khẩu nhập lại có trùng khớp không
    if (passwordController.text != repasswordController.text) {
      _errorRePassMessage(context);
      return;
    }

    // Hiển thị tiện ích loading
    progressDialog.show();

    try {
      // Kiểm tra xem người dùng đã tồn tại trong cơ sở dữ liệu chưa
      bool userExists = await checkIfUserExists(emailController.text);
      if (userExists) {
        // Đóng tiện ích loading
        progressDialog.hide();
        _errorAccountExistMessage(context);
        return;
      }

      // Thực hiện đăng ký người dùng
      await _signup();
      // Đăng ký thành công, thêm thông tin người dùng vào Firebase Realtime Database
      DatabaseReference userRef = FirebaseDatabase.instance.reference().child('TaiKhoan');
      DatabaseReference newUserRef = userRef.push(); // Tạo một tham chiếu mới và lấy ID
      String newUserId = newUserRef.key!; // Lấy ID của mục mới được tạo

      User user = User(
          id: newUserId,
          email: emailController.text,
          password: passwordController.text,
          ho: '',
          tenLot: '',
          ten: '',
          soDienThoai: '',
          gioiTinh: '',
          diaChi:'',
          ngaySinh: '',
          anhDocGia: '',
          role: ''
      );
      // Lưu thông tin người dùng vào Firebase Realtime Database
      await newUserRef.set(user.toJson()); // Lưu thông tin người dùng vào cơ sở dữ liệu

      // Đóng tiện ích loading
      progressDialog.hide();

      // Hiển thị thông báo thành công
      _succesMessage(context);

      // Chờ 2 giây trước khi chuyển đến trang chủ
      await Future.delayed(const Duration(seconds: 2));
      // Ẩn thông báo thành công
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500), // Độ dài của animation
          pageBuilder: (context, animation, secondaryAnimation) => const DashBoardScreen(), // Builder cho trang chủ
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Bắt đầu từ ngoài phải
            const end = Offset.zero; // Kết thúc ở vị trí ban đầu
            const curve = Curves.ease; // Kiểu animation
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve)); // Tạo tween
            var offsetAnimation = animation.drive(tween); // Áp dụng tween vào animation
            return SlideTransition(
              position: offsetAnimation, // Sử dụng SlideTransition với animation đã thiết lập
              child: child,
            );
          },
        ),
      );
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error during sign up: $e');
      // Đóng tiện ích loading
      progressDialog.hide();
      // Hiển thị thông báo lỗi cho người dùng
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng ký không thành công. Vui lòng thử lại sau.'),
        ),
      );
    }
  }

  Future<void> _signup() async {
    // Lấy email và mật khẩu từ các controllers
    String email = emailController.text;
    String password = passwordController.text;

    try {
      // Gọi phương thức đăng ký người dùng từ AuthService
      await _auth.createUserWithEmailAndPassword(email, password);
      // Nếu đăng ký thành công, bạn có thể thực hiện các hành động khác ở đây
    } catch (e) {
      // Nếu xảy ra lỗi, throw lên ngoài để xử lý ở phương thức gọi
      throw e;
    }
  }

  Future<bool> checkIfUserExists(String email) async {
    // Thực hiện truy vấn cơ sở dữ liệu Firebase
    DatabaseReference ref = FirebaseDatabase.instance.reference().child("TaiKhoan");
    DataSnapshot snapshot = await ref.orderByChild("email").equalTo(email).once().then((snapshot) => snapshot.snapshot);

    // Kiểm tra xem có bất kỳ kết quả nào từ truy vấn hay không
    return snapshot.value != null;
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

  bool _isPasswordValid(String password) {
    // Biểu thức chính quy để kiểm tra mật khẩu
    final RegExp passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
      caseSensitive: false,
      multiLine: false,
    );
    return passwordRegex.hasMatch(password) && containsUpperCase(password);
  }

  bool containsUpperCase(String password) {
    // Kiểm tra xem mật khẩu có chứa ký tự in hoa không
    for (var char in password.split('')) {
      if (char == char.toUpperCase() && char != char.toLowerCase()) {
        return true;
      }
    }
    return false;
  }
}

//Thông báo đăng ký thành công

_succesMessage(BuildContext context){
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Container(
            padding: const EdgeInsets.all(8),
            height: 80,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 81, 146, 83),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle,color: Colors.white,size: 40,),

                SizedBox(width: 15,),

                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Succes", style: TextStyle(fontSize: 15,color: Colors.white),),

                    Spacer(),
                    Text('Tạo tài khoản thành công...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,)
                  ],
                ))
              ],
            ),
          ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      )
  );
}

// Thông báo yêu cầu điền thông tin đầy đủ
_errorNullMessage(BuildContext context){
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(8),
          height: 80,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 179, 89, 89),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: const Row(
            children: [
              Icon(Icons.error_outline,color: Colors.white,size: 40,),

              SizedBox(width: 15,),

              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Opps. An Error Occured", style: TextStyle(fontSize: 15,color: Colors.white),),

                  Spacer(),
                  Text('Vui lòng điền đầy đủ thông tin.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,)
                ],
              ))
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      )
  );
}

// Thông báo Email không hợp lệ
_errorEmailMessage(BuildContext context){
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(8),
          height: 90,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 179, 89, 89),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: const Row(
            children: [
              Icon(Icons.error_outline,color: Colors.white,size: 40,),

              SizedBox(width: 15,),

              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Opps. An Error Occured", style: TextStyle(fontSize: 15,color: Colors.white),),

                  Spacer(),
                  Text('Email không hợp lệ. Vui lòng kiểm tra lại.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,)
                ],
              ))
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      )
  );
}

// Thông báo Mật khẩu không hợp lệ
_errorPassMessage(BuildContext context){
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(8),
          height: 110,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 179, 89, 89),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: const Row(
            children: [
              Icon(Icons.error_outline,color: Colors.white,size: 40,),

              SizedBox(width: 15,),

              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Opps. An Error Occured", style: TextStyle(fontSize: 15,color: Colors.white),),

                  Spacer(),
                  Text('Mật khẩu không hợp lệ. Mật khẩu phải có '
                      'ít nhất 8 ký tự, bao gồm '
                      'chữ hoa, chữ thường và số.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,)
                ],
              ))
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      )
  );
}

// Thông báo Re pass khác với Pass
_errorRePassMessage(BuildContext context){
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(8),
          height: 80,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 179, 89, 89),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: const Row(
            children: [
              Icon(Icons.error_outline,color: Colors.white,size: 40,),

              SizedBox(width: 15,),

              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Opps. An Error Occured", style: TextStyle(fontSize: 15,color: Colors.white),),

                  Spacer(),
                  Text('Mật khẩu nhập lại không trùng khớp. Vui lòng nhập lại.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,)
                ],
              ))
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      )
  );

}

// Thông báo tài khoản ton tai trong he thong
_errorAccountExistMessage(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(8),
          height: 90,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 179, 89, 89),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white, size: 40,),

              SizedBox(width: 15,),

              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Opps. An Error Occured",
                    style: TextStyle(fontSize: 15, color: Colors.white),),

                  Spacer(),
                  Text(
                    'Tài khoản đã tồn tại trong hệ thông, Không thể tạo tài khoản!.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,)
                ],
              ))
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      )
  );
}