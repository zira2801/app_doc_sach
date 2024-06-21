import "dart:convert";

import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_database/firebase_database.dart";
import "package:hive/hive.dart";
part 'user_model.g.dart';
Users usersFromJson(String str) => Users.fromJson(json.decode(str));
@HiveType(typeId: 8)
class Users {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String fullName;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String gender;
  @HiveField(5)
  final String address;
  @HiveField(6)
  final DateTime? age;
  @HiveField(7)
  final String? avatar;

  Users({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.gender,
    required this.address,
    required this.age,
    required this.avatar,
  });

  factory Users.fromJson(Map<String, dynamic> data) =>
       Users(
        id: data['id'].toString(),
        fullName: data['fullName'].toString(), // Xử lý trường hợp fullName là null
        email: data['email'].toString() ,
        age: data['age'] == null ? null : DateTime.parse(data['age']), // Xử lý trường hợp age là null
        phone: data['phone'].toString(),
        gender: data['gender'].toString(),
        address: data['address'].toString(),
        avatar: data['image'].toString(),
        /*avatar: data.containsKey('image') ? (data['image'].toString().isNotEmpty ? data['image']['url'] : null) : null,*/
      );
  }
