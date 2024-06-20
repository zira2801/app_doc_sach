import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

@HiveType(typeId: 8)
class Users {
  @HiveField(0)
  int _id;
  @HiveField(1)
  String _fullName;
  @HiveField(2)
  String _email;
  @HiveField(3)
  DateTime? _age;
  @HiveField(4)
  String? _image;
  @HiveField(5)
  String _phone;
  @HiveField(6)
  String _gender;
  @HiveField(7)
  String _address;

  Users({
    required int id,
    required String fullName,
    required String email,
    required DateTime? age,
    required String? image,
    required String phone,
    required String gender,
    required String address,
  })  : _id = id,
        _fullName = fullName,
        _email = email,
        _age = age,
        _image = image,
        _phone = phone,
        _gender = gender,
        _address = address;

  factory Users.fromJson(Map<String, dynamic> data) {
    var attributes = data['attributes'];
    return Users(
      id: data['id'],
      fullName: data['fullName']?.toString() ?? 'N/A',
      email: data['email']?.toString() ?? 'N/A',
      age: data['age'] == null ? null : DateTime.parse(attributes['age']),
      phone: data['phone']?.toString() ?? 'N/A',
      gender: data['gender']?.toString() ?? 'N/A',
      address: data['address']?.toString() ?? 'N/A',
      image: data['image']?.toString() ?? 'N/A',
    );
  }

  // Getters
  int get id => _id;
  String get fullName => _fullName;
  String get email => _email;
  DateTime? get age => _age;
  String? get image => _image;
  String get phone => _phone;
  String get gender => _gender;
  String get address => _address;

  // Setters
  set id(int id) {
    _id = id;
  }

  set fullName(String fullName) {
    _fullName = fullName;
  }

  set email(String email) {
    _email = email;
  }

  set age(DateTime? age) {
    _age = age;
  }

  set image(String? image) {
    _image = image;
  }

  set phone(String phone) {
    _phone = phone;
  }

  set gender(String gender) {
    _gender = gender;
  }

  set address(String address) {
    _address = address;
  }
}
