import 'package:consume/api/Auth.dart';
import 'package:flutter/material.dart';
import 'package:quantumlabs_flutter_widgets/quantumlabs_flutter_widgets.dart';
import 'package:flutter/services.dart';
import 'package:consume/views/SingupView.dart';
import 'package:consume/views/HomeView.dart';
// import 'package:consume/services/Session.dart' as session;

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      key: _key,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            children: <Widget>[
              _imageDisplay(),
              Padding(
                  padding: CustomEdgeInsets().only8lp(bottom: true, top: true)),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _emailField(),
                    Padding(padding: CustomEdgeInsets().only8lp(bottom: true)),
                    _passwordField(),
                  ],
                ),
              ),
              Padding(padding: CustomEdgeInsets().only8lp(bottom: true)),
              _loginButton(),
              _createUserButton(),
            ],
          ),
        )),
      ),
    );
  }

  Widget _emailField() => TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "E-mail",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        validator: (value) => ValidationHelper().checkEmail(value),
      );

  Widget _passwordField() => TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        validator: (value) => ValidationHelper().checkPassword(value),
      );

  Widget _loginButton() => RoundedButton(
      // buttonColor: Colors.blue,
      buttonText: Text("Login!"),
      buttonClick: () {
        if (!_formKey.currentState.validate()) {
        } else {
          Map<String, dynamic> data = {
            "email": _emailController.text,
            "password": _passwordController.text
          };

          Auth().login(data).then((res) {
            if (res['user'] != null) {
              print(res['user']['id']);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                  (Route<dynamic> route) => false);
            } else {
              DialogHelper(context).showSimpleDialog(
                  "Erro ao logar", "Usuário ou senha incorreta");
            }
          }).catchError((err) {});
        }
      });
  Widget _imageDisplay() => Column(
        children: <Widget>[
          Image.asset(
            'assets/Twitter.png',
          ),
        ],
      );

  Widget _createUserButton() => RoundedButton(
        buttonText: Text("Create User"),
        buttonClick: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SingupView()));
        },
      );
}
