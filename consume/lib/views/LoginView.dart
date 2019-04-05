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
        backgroundColor: Color.fromRGBO(34, 34, 34, 1),
        title: Text("Login"),
        centerTitle: true,
      ),
      key: _key,
      body: Column(
        children: <Widget>[
          _imageDisplay(),
          SingleChildScrollView(
            child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: _emailField(),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: _passwordField(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: _loginButton(),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 40),
                    child: _createUser(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _emailField() => Container(
          child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "E-mail",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(34, 34, 34, 1),),
          ),
        ),
        validator: (value) => ValidationHelper().checkEmail(value),
      ));

  Widget _passwordField() => Container(
        child: TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(34, 34, 34, 1),),
            ),
          ),
          validator: (value) => ValidationHelper().checkPassword(value),
        ),
      );

  Widget _loginButton() => RoundedButton(
      buttonColor: Color.fromRGBO(34, 34, 34, 1),
      buttonText: Text("Login", style: TextStyle(color: Colors.white),),
      buttonClick: () {
        if (!_formKey.currentState.validate()) {
        } else {
          Map<String, dynamic> data = {
            "email": _emailController.text,
            "password": _passwordController.text
          };

          Auth().login(data).then((res) {
            if (res['user'] != null) {
              print(res['user']['id'].toString());
              int id;
              id = res['user']['id'];
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView(id)),
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
            'assets/TwitterDark.png',
            height: 180,
            width: 180,
          ),
        ],
      );

  Widget _createUser() => GestureDetector(
        child: Text(
          "Criar Usuário",
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: Color.fromRGBO(34, 34, 34, 1),),
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SingupView()));
        },
      );
}
