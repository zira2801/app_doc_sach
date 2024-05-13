import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      log("Error occurred: $e");
      // Ném ra ngoại lệ để bắt lỗi ở nơi gọi
      throw e;
    }
  }

  Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log("Firebase Auth Exception: ${e.code}");
      // Ném ra ngoại lệ để bắt lỗi ở nơi gọi
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      log("Error occurred: $e");
      rethrow;
    }
  }

  //Dang nhap bang Google
 Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
// Once signed in, return the UserCredential
   final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
   final user = userCredential.user;

   if (user != null) {
     // Đăng nhập thành công, lưu thông tin người dùng vào Firebase Realtime Database
     DatabaseReference userRef = FirebaseDatabase.instance.reference().child('TaiKhoan');
     DatabaseReference newUserRef = userRef.push(); // Tạo một tham chiếu mới và lấy ID
     String newUserId = newUserRef.key!; // Lấy ID của mục mới được tạo

     Map<String, dynamic> userData = {
       'id': newUserId,
       'email': user.email,
       'displayName': user.displayName,
       'avatar': user.photoURL,
       'loaitaikhoan': 'google', // Đánh dấu rằng người dùng đăng nhập bằng Google
       'ho': '',
       'tenLot': '',
       'ten': '',
       'soDienThoai': '',
       'gioiTinh': '',
       'diaChi':'',
       'ngaySinh': '',
       'role': ''
     };

     await newUserRef.set(userData); // Lưu thông tin người dùng vào cơ sở dữ liệu
   }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      log("Error occurred: $e");
      // Ném ra ngoại lệ để bắt lỗi ở nơi gọi
      throw e;
    }
  }
}
