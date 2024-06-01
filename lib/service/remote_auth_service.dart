import 'dart:convert';

import 'package:app_doc_sach/const.dart';
import 'package:http/http.dart' as http;

class RemoteAuthService {
  var client = http.Client();

  Future<dynamic> signUp({
    required String email,
    required String password,
}) async {
    var body = {
      "username": email,
      "email": email,
      "password": password,
      'role_user': "client",
      'type': "email",
    };
    var response = await client.post(
      Uri.parse('$baseUrl/api/auth/local/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    return response;
  }

  Future<dynamic> createProfile({
    required String token,
    required String fullName,
  }) async {
    var body = {
      "fullName": fullName
    };
    var response = await client.post(
      Uri.parse('$baseUrl/api/profile/me'),
      headers: {"Content-Type": "application/json",
      "Authorization": "Bearer $token"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<dynamic> signIn({
    required String email,
    required String password,
  }) async {
    var body = {
      "identifier" : email,
      "password": password
    };
    var response = await client.post(
      Uri.parse('$baseUrl/api/auth/local'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    return response;
  }

  Future<dynamic> getProfile({
    required String token
  }) async {
    var response = await client.get(
      Uri.parse('$baseUrl/api/profile/me'),
      headers: {"Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    return response;
  }
}