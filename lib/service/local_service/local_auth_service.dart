import 'package:hive/hive.dart';
import '../../model/user_model.dart';

class LocalAuthService {
  late Box<String> _tokenBox;
  late Box<Users> _userBox;

  Future<void> init() async {
    _tokenBox = await Hive.openBox<String>('token');
    _userBox = await Hive.openBox<Users>('user');
    print('Token box opened: ${_tokenBox.isOpen}');
    print('User box opened: ${_userBox.isOpen}');
  }

  Future<void> addToken({required String token}) async {
    await _tokenBox.put('token', token);
  }

  Future<void> addUser({required Users user}) async {
    await _userBox.put('user', user);
  }

  Future<void> clear() async {
    await _tokenBox.clear();
    await _userBox.clear();
  }

  String? getToken() => _tokenBox.get('token');
  Users? getUser() => _userBox.get('user');
}
