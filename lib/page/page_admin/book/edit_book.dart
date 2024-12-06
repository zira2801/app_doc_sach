import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/book_model.dart';

class EditBookPage extends StatelessWidget {
  final Book book;
  const EditBookPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa sách'),
      ),
      body: Center(
        child: Text('Trang chỉnh sửa sách cho: ${book.title}'),
      ),
    );
  }
}