import 'package:consume/views/LoginView.dart';
import 'package:flutter/material.dart';
import 'package:consume/services/Http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  MyApp(){
    http.urlBase = "http://25.52.121.201:3333";
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: LoginView()
    );
  }
}
