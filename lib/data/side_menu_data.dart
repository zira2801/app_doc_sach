import 'package:app_doc_sach/model/menu_model.dart';
import 'package:flutter/material.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    MenuModel(icon: Icons.home, title: 'Dashboard'),
    MenuModel(icon: Icons.book, title: 'Book'),
    MenuModel(icon: Icons.category, title: 'Category'),
    MenuModel(icon: Icons.person_add_alt, title: 'Author'),
    MenuModel(icon: Icons.person, title: 'User'),
    MenuModel(icon: Icons.logout, title: 'SignOut'),
  ];
}