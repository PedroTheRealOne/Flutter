import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{ 
  runApp(MaterialApp(
      home: MyApp(),
    ));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light
);

final ThemeData kDefaultTheme =ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400], 
);

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Online Chat",
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).platform ==TargetPlatform.iOS ? kIOSTheme :kDefaultTheme,
      home: ChatScreen(),
    );
  }
}