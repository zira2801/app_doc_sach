import "dart:convert";
import "package:hive/hive.dart";
part 'user_model.g.dart';
Users usersFromJson(String str) => Users.fromJson(json.decode(str));
@HiveType(typeId: 8)
class Users {
  @HiveField(0)
   String? id;
  @HiveField(1)
  String email;
  @HiveField(2)
   String fullName;
  @HiveField(3)
  String phone;
  @HiveField(4)
  String gender;
  @HiveField(5)
  String address;
  @HiveField(6)
  DateTime? age;
  @HiveField(7)
  String? avatar;

  Users({
    this.id,
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
