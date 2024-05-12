import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

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

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Error occurred: $e");
      // Ném ra ngoại lệ để bắt lỗi ở nơi gọi
      throw e;
    }
  }
}
