import 'package:flutter/material.dart';
import 'ui/home_page.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(hintColor: Colors.white),
  ));
}