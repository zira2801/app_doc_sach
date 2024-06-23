
import 'dart:convert';

import 'package:app_doc_sach/model/book_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../const.dart';
class BookController extends GetxController{
  static BookController instance = Get.find();
  Rxn<Book> book = Rxn<Book>();
  late BuildContext context;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<List<Book>> getBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/api/books?populate=*'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Book.fromJson(json['attributes'])).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Book>> searchBooks(String query) async {
    final response = await http.get(
        Uri.parse('$baseUrl/api/books?populate=*&filters[title][\$containsi]=$query')
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Book.fromJson(json['attributes'])).toList();
    } else {
      throw Exception('Failed to search books');
    }
  }
}