import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:clothing_store/models/user_model.dart';
import 'package:clothing_store/models/cart_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant(
        builder: (context, child, model){
          return ScopedModel<CartModel>(
        model: CartModel(model),
        child: MaterialApp(
      title: "Clothing Store",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4, 125, 141)
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      ),
      );
        },
      )
    );
  }
}