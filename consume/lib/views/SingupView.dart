import 'package:flutter/material.dart';
import 'package:quantumlabs_flutter_widgets/quantumlabs_flutter_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:consume/api/Auth.dart';

class SingupView extends StatefulWidget {
  @override
  _SingupViewState createState() => _SingupViewState();
}

class _SingupViewState extends State<SingupView> {

  final _apiWeb = 'http://127.0.0.1:3333/auth/register';
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create User"),
        ),
        key: _scaffoldKey,
        body: Container(
          padding: CustomEdgeInsets().all16lp(),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(padding: CustomEdgeInsets().all8lp()),
                _usernameField(),
                Padding(padding: CustomEdgeInsets().all8lp()),
                _emailField(),
                Padding(padding: CustomEdgeInsets().all8lp()),
                _passwordField(),
                Padding(padding: CustomEdgeInsets().all8lp()),
                _createButton()
              ],
            ),
          ),
        ));
  }

  Widget _emailField() => Form(
        key: _formKey,
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: "E-mail",
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue))),
              validator: (text){
                if(text.isEmpty) return "Invalid E-mail";
              },
        ),
      );

  Widget _usernameField() => Form(
    key: _formKey3,
    child: TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: "Username",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue)
        )
      ),
      validator: (text){
        if(text.isEmpty) return "Invalid Username";
      },
    ),
  );

  Widget _passwordField() => Form(
        key: _formKey2,
        child: TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue))),
              validator: (text){
                if(text.isEmpty) {return "Invalid Password";}
              },
        ),
      );

  Widget _createButton() => RoundedButton(
    buttonText: Text("Create"),
    buttonClick: (){

      Map<String, dynamic> data = {"email": _emailController.text, "username": _usernameController.text, "password": _passwordController.text};

      Auth().singUp(data);
      Navigator.pop(context);
    },
  );

  
}
