import 'package:flutter/cupertino.dart';

class TabProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void updateTab(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}