import 'package:flutter/foundation.dart';
import '../database_helper.dart';

class AuthProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  String? _loggedInUser;

  Future<void> saveUser(String username, String password) async {
    await _dbHelper.insertUser(username, password);
    _loggedInUser = username;
    notifyListeners();
  }

  Future<Map<String, String?>?> getUser(String username) async {
    final user = await _dbHelper.getUser(username);
    if (user != null) {
      return {'username': user['username'], 'password': user['password']};
    }
    return null;
  }

  Future<bool> validateUser(String username, String password) async {
    final user = await getUser(username);
    if (user != null && user['password'] == password) {
      _loggedInUser = username;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logoutUser() async {
    _loggedInUser = null;
    notifyListeners();
  }

  Future<bool> isUserLoggedIn() async {
    return _loggedInUser != null;
  }

  String? get loggedInUser => _loggedInUser;
}
