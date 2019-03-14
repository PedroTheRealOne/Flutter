import 'package:flutter/material.dart';
import 'package:clothing_store/screens/singup_screen.dart';
import 'package:clothing_store/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {

  final _formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: (){},
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
}