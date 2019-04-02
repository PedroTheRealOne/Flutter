import 'dart:convert';
import 'dart:async';
import 'package:consume/services/Http.dart' as http;
import 'package:consume/services/Session.dart' as session;

class Auth {
  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    final response = await http.post('auth', data, false);

    Map<String, dynamic> user = json.decode(response.body);
    if (user['user'] != null) {
      final token = user['token'];
      await http.setMobileToken(token);
      await session.setUserSession(user);
    }
    return user;
  }

  Future<Map<String, dynamic>> singUp(Map<String, dynamic> data) async {
    final response = await http.post('auth/register', data);
    Map<String, dynamic> newUser = json.decode(response.body);
    return newUser;
  }

  Future<Map<String, dynamic>> isLogged() async {
    return await session.getUserSession();
  }

  Future<bool> logout() async {
    await http.removeMobileToken();
    await session.removeUserSession();

    return true;
  }
}
