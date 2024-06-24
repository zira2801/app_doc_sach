
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_doc_sach/model/book_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:html' as html;
import '../const.dart';
import '../model/file_upload.dart';
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
    final response = await http.get(Uri.parse('$baseUrl/api/books?populate[authors]=*&populate[categories]=*&populate[chapters][populate]=files&populate[cover_image]=*'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Book.fromJson(json['attributes'])).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<FileUpload?> uploadImage(dynamic imageData) async {
    var uri = Uri.parse('$baseUrl/api/upload/');
    var request = http.MultipartRequest('POST', uri);

    if (kIsWeb) {
      // Xử lý cho web
      if (imageData is String && imageData.startsWith('data:image')) {
        // Đây là một Data URL
        var bytes = base64Decode(imageData.split(',').last);
        request.files.add(http.MultipartFile.fromBytes(
          'files',
          bytes,
          filename: 'image.png',
          contentType: MediaType('image', 'png'),
        ));
      } else {
        throw Exception('Invalid image data for web');
      }
    } else {
      // Xử lý cho mobile
      if (imageData is String) {
        var file = File(imageData);
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();
        request.files.add(http.MultipartFile(
          'files',
          stream,
          length,
          filename: file.path.split('/').last,
          contentType: MediaType('image', 'png'),
        ));
      } else {
        throw Exception('Invalid image data for mobile');
      }
    }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var fileUpload = FileUpload.fromJson(jsonResponse[0]);
        print('Upload thành công: ${fileUpload.url}');
        return fileUpload;
      } else {
        print('Lỗi khi tải lên ảnh. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Lỗi khi tải lên ảnh: $e');
      return null;
    }
  }
  Future<bool> createBook(Book book) async {
    final url = Uri.parse('$baseUrl/api/books');
    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(book.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Book created successfully');
        return true;
      } else {
        print('Failed to create book. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating book: $e');
      return false;
    }
  }
}

