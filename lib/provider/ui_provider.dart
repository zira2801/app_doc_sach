import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  late SharedPreferences storage;
  //Dark mode toggle action
  void changeTheme() {
    _isDark = !_isDark;
    storage.setBool("isDark", _isDark);
    _updateStatusBarStyle(); // Cập nhật lại trạng thái thanh trạng thái
    notifyListeners();
  }

  // Hàm cập nhật trạng thái thanh trạng thái
  void _updateStatusBarStyle() {
    if (_isDark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color.fromRGBO(232, 245, 233, 1.0),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ));
    }
  }

  //Custom dark theme
  final darkTheme = ThemeData(
    primaryColor: Colors.black12,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black12,
  );
  //Custom light theme
  final lightTheme = ThemeData(
    primaryColor: Color.fromRGBO(232, 245, 233, 1.0),
    brightness: Brightness.light,
    primaryColorDark: Color.fromRGBO(232, 245, 233, 1.0),
  );

  //Save Last Change

  init() async {
    //After we re run app
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool("isDark") ?? false;
    notifyListeners();
  }
}
