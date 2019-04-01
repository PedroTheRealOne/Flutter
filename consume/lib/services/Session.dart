import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

// the storage key for the session
const String _storageKeyUserSession = "user_session";

/// Method that returns the session from Shared Preferences
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<Map<String, dynamic>> getUserSession() async {
  final SharedPreferences prefs = await _prefs;
  Map<String, dynamic> userData;
  var userSession = prefs.getString(_storageKeyUserSession);
  if(userSession != null){
     userData = json.decode(userSession);
  }
  else{
    userData = null;
  }
  return userData;
}

/// Method that saves the session in Shared Preferences
Future<bool> setUserSession(Map<String, dynamic> userData) async {
  final SharedPreferences prefs = await _prefs;

  final jsonData = json.encode(userData);

  return prefs.setString(_storageKeyUserSession, jsonData);
}

/// Method that erase the token from Shared Preferences
Future<bool> removeUserSession() async {
  final SharedPreferences prefs = await _prefs;

  return prefs.remove(_storageKeyUserSession);
}
