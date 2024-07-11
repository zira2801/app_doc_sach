import 'dart:convert';

import 'package:app_doc_sach/const.dart';
import 'package:app_doc_sach/model/author_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
class AuthorController extends GetxController{
  static AuthorController instance = Get.find();
  Rxn<Author> author = Rxn<Author>();
  late BuildContext context;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  Future<List<Author>> fetchAuthors() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/authors')); // Thay thế bằng đường dẫn API thực của bạn

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data']; // Giải mã phản hồi JSON
        List<Author> authorsList = data.map((json) => Author.fromJson(json)).toList(); // Ánh xạ các đối tượng JSON thành đối tượng Author
        return authorsList; // Trả về danh sách các tác giả
      } else {
        throw Exception('Failed to load authors');
      }
    } catch (e) {
      throw Exception('Error loading authors: $e'); // Ném ra một ngoại lệ nếu có lỗi khi tải dữ liệu
    }
  }
}