import 'package:flutter/material.dart';

class TabState extends ChangeNotifier {
  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  void setSelectedTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }
}