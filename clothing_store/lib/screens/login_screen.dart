import 'package:flutter/material.dart';
import 'package:clothing_store/screens/singup_screen.dart';
import 'package:clothing_store/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey =GlobalKey<FormState>();

  final _emailController =TextEditingController();
  final _passController =TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text("Create Account",
            style: TextStyle(
              fontSize: 15.0
            ),
            ),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SingupScreen())
              );
            },
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoading)
            return Center(child: CircularProgressIndicator(),); 

          return Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "E-mail"
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (text){
                if(text.isEmpty || text.contains("@")) return "Invalid E-mail";
              },
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              controller: _passController,
              decoration: InputDecoration(
                hintText: "Password"
              ),
              obscureText: true,
              validator: (text){
                if(text.isEmpty || text.length < 6) return "Invalid password";
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: (){
                  if(_emailController.text.isEmpty){
                     _scaffoldKey.currentState.showSnackBar(
                     SnackBar(content: Text("Check the email field!"),
                      backgroundColor: Colors.redAccent,
                      duration: Duration(seconds: 2),
                    )
                    );
                  } else {
                    model.recoverPass(_emailController.text);
                      _scaffoldKey.currentState.showSnackBar(
                     SnackBar(content: Text("Check your email!"),
                      backgroundColor: Theme.of(context).primaryColor,
                      duration: Duration(seconds: 2),
                    )
                    );
                  }
                },
                child: Text("Forgot password",
                textAlign: TextAlign.right,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
            SizedBox(height: 16.0,),
            SizedBox(height: 44.0,
            child: RaisedButton(
              child: Text("Login",
                style: TextStyle(
                  fontSize: 18.0
                ),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: (){
                if(_formKey.currentState.validate()){

                }
                model.singIn(
                  email: _emailController.text,
                  pass: _passController.text,
                  onSuccess: _onSuccess,
                  onFail: _onFail,
                );
              },
            ),
            ),
          ],
        ),
      );
        },
      ),
    );
  }

  void _onSuccess(){
    Navigator.of(context).pop();
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Singin Fail!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
      )
    );
  }
}