import 'package:flutter/material.dart';

class SingupScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create account"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: "Name"
              ),
              validator: (text){
                if(text.isEmpty) return "Invalid Name";
              },
            ),
            SizedBox(height: 16.0,),
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
                if(text.isEmpty || text.length < 6) return "Invalid Password";
              },
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Address"
              ),
              validator: (text){
                if(text.isEmpty ) return "Invalid Address";
              },
            ),
            SizedBox(height: 16.0,),
            SizedBox(height: 44.0,
            child: RaisedButton(
              child: Text("Create account",
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
      ),
    );
  }
}