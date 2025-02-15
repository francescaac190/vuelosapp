import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../domain/model.dart';

class AuthState extends ChangeNotifier {
  UserApp _user = UserApp();
  UserApp get userInfo => _user;

  bool get isAuthorized => _user.apiToken != null && _user.apiToken!.isNotEmpty;

  Future<bool> login(String phone, String password) async {
    final url =
        Uri.parse("https://stage.justbeesolutions.com/beeapi/api/login");

    try {
      final response = await http.post(
        url,
        body: {"cel": phone, "password": password},
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["estado"] == 100) {
          _user = UserApp(
            username: phone,
            apiToken: data["token"],
          );

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('apiToken', _user.apiToken!);
          await prefs.setString('username', _user.username!);

          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      print("Error en login: $e");
      return false;
    }
  }

  Future<bool> tryLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('apiToken');
    final savedUsername = prefs.getString('username');

    if (savedToken != null && savedToken.isNotEmpty) {
      _user = UserApp(
        username: savedUsername,
        apiToken: savedToken,
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() async {
    _user = UserApp();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('apiToken');
    await prefs.remove('username');
    notifyListeners();
  }
}
