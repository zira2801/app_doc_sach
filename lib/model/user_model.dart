import "package:firebase_database/firebase_database.dart";

class User {
  final String id;
  final String email;
  final String password; // Note: It's not recommended to store passwords in plain text, consider using Firebase Authentication instead
  final String ho;
  final String tenLot;
  final String ten;
  final String soDienThoai;
  final String gioiTinh;
  final String diaChi;
  final String ngaySinh;
  final String anhDocGia;
  final String role;


  User({
    required this.id,
    required this.email,
    required this.password,
    required this.ho,
    required this.tenLot,
    required this.ten,
    required this.soDienThoai,
    required this.gioiTinh,
    required this.diaChi,
    required this.ngaySinh,
    required this.anhDocGia,
    required this.role

  });

  // Convert User object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'ho': ho,
      'tenLot': tenLot,
      'ten': ten,
      'soDienThoai': soDienThoai,
      'gioiTinh': gioiTinh,
      'diaChi': diaChi,
      'ngaySinh': ngaySinh,
      'anhDocGia': anhDocGia ,
      'role': role
    };
  }
}