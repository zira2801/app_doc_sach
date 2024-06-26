import 'package:app_doc_sach/page/page_admin/book/display_book.dart';
import 'package:flutter/material.dart';

import '../../../const/constant.dart';
import '../author/author_admin.dart';
import '../author/display_author.dart';
import '../category/category_admin.dart';
import '../main_screen.dart';
import '../user/user_admin.dart';

class BookAdminWidget extends StatefulWidget {
  const BookAdminWidget({super.key});

  @override
  State<BookAdminWidget> createState() => _BookAdminWidgetState();
}

class _BookAdminWidgetState extends State<BookAdminWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        brightness: Brightness.dark,
      ),
      home:  const DisplayBook(),
      routes: {
        '/homepage': (context) => const MainScreen(),
        '/bookpage': (context) => const BookAdminWidget(),
        '/category': (context) => const CategoryAdminWidget(),
        '/author': (context) => const AuthorAdminWidget(),
        '/user': (context) => const UserAdminWidget(),
      },
    );;
  }
}
