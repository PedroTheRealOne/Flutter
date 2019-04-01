import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

// the storage key for the token
const String _storageKeyMobileToken = "token";
// the URL of the Web Server

//References
BuildContext context;
String _urlBase;
String _environment;
const OK = 200;
const NOT_AUTHORIZED = 401;
const FORBIDDEN = 403;
const INTERNAL_ERROR = 500;
const BAD_GATEWAY = 502;

set urlBase(String urlBase) {
  _urlBase = urlBase;
}

set environment(String env) {
  _environment = env;
}

/// Method that returns the token from Shared Preferences
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<String> getMobileToken() async {
  final SharedPreferences prefs = await _prefs;
  return prefs.getString(_storageKeyMobileToken);
}

/// Method that saves the token in Shared Preferences
Future<bool> setMobileToken(String token) async {
  final SharedPreferences prefs = await _prefs;

  return prefs.setString(_storageKeyMobileToken, token);
}

/// Method that erase the token from Shared Preferences
Future<bool> removeMobileToken() async {
  final SharedPreferences prefs = await _prefs;

  return prefs.remove(_storageKeyMobileToken);
}

Future<http.Response> post(String action, Map data, [bool auth = true]) async {
  Map<String, String> headers = {'content-type': 'application/json'};

  if (auth) {
    headers['Authorization'] = 'Bearer ${await getMobileToken()}';
  }

  final body = json.encode(data);

  final response =
      await http.post('$_urlBase/$action', body: body, headers: headers);
  log('Route POST: $_urlBase/$action');
  log('Http ${response.statusCode}: ${response.body}');

  if (response.statusCode == NOT_AUTHORIZED) {
    rejectUser();
  }

  return response;
}

Future<http.Response> put(String action, [Map data, bool auth = true]) async {
  Map<String, String> headers = {'content-type': 'application/json'};

  if (auth) {
    headers['Authorization'] = 'Bearer ${await getMobileToken()}';
  }

  final body = data != null ? json.encode(data) : null;

  final response =
      await http.put('$_urlBase/$action', body: body, headers: headers);
  log("Route PUT: $_urlBase/$action");
  log("Http ${response.statusCode}: ${response.body}");
  return response;
}

Future<http.Response> get(String action, [bool auth = true]) async {
  Map<String, String> headers = {'content-type': 'application/json'};

  if (auth) {
    headers['Authorization'] = "Bearer ${await getMobileToken()}";
  }

  final response = await http
      .get('$_urlBase/$action', headers: headers)
      .timeout(Duration(seconds: 35))
      .catchError((err) => throw err);

  log("Route GET: $_urlBase/$action");
  log("Http ${response.statusCode}: ${response.body}");

  if (response.statusCode == NOT_AUTHORIZED) {
    rejectUser();
  } else if (response.statusCode == INTERNAL_ERROR ||
      response.statusCode == BAD_GATEWAY) {
    throw response.statusCode;
  }

  return response;
}

Future<http.Response> delete(String action, [bool auth = true]) async {
  Map<String, String> headers = {'content-type': 'application/json'};

  if (auth) {
    headers['Authorization'] = "Bearer ${await getMobileToken()}";
  }

  final response = await http.delete('$_urlBase/$action', headers: headers);
  log("Route DELETE: $_urlBase/$action");
  log("Http ${response.statusCode}: ${response.body}");

  if (response.statusCode == NOT_AUTHORIZED) {
    rejectUser();
  }

  return response;
}

Future<http.Response> multipartRequest(String action, Map data, Map files,
    [bool auth = true]) async {
  Map<String, String> headers = {'content-type': 'application/json'};

  if (auth) {
    headers['Authorization'] = "Bearer ${await getMobileToken()}";
  }

  var request = http.MultipartRequest("PUT", Uri.parse('$_urlBase/$action'));

  headers.forEach((key, value) {
    request.headers[key] = value;
  });

  data.forEach((key, value) {
    request.fields[key] = value;
  });
  log("Request Fields: ${request.fields}");
  files.forEach((key, value) async {
    if (value != null) {
      var bytes = File(value).readAsBytesSync();
      request.files.add(
        new http.MultipartFile.fromBytes(
          key,
          bytes,
          filename: value,
          contentType: new MediaType('application', "jpg"),
        ),
      );
    }
  });
  log("Request Files: ${request.files.toString()}");

  StreamedResponse multipartResponse = await request.send();
  final response = await http.Response.fromStream(multipartResponse);

  log("Route MULTIPART: $_urlBase/$action");
  log("Http ${response.statusCode}: ${response.body}");

  if (response.statusCode == NOT_AUTHORIZED) {
    rejectUser();
  } else if (response.statusCode == INTERNAL_ERROR ||
      response.statusCode == BAD_GATEWAY) {
    throw json.decode(response.body);
  }

  return response;
}

void rejectUser() async {
  // await Auth().logout(context);
  // Navigator.of(context).pushAndRemoveUntil(
  //     (MaterialPageRoute(builder: (context) => LoginView(true))),
  //     (Route<dynamic> route) => false);
}

void log(String msg) {
  if (_environment != "prod") {
    print(msg);
  }
}
