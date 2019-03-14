import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:clothing_store/models/user_model.dart';

class SingupScreen extends StatefulWidget {
  @override
  _SingupScreenState createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final _nameController =TextEditingController();
  final _emailController =TextEditingController();
  final _passController =TextEditingController();
  final _adressController =TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Create account"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
          builder: (context, child,model){
            if (model.isLoading)
              return Center(child: CircularProgressIndicator(),);

            return Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Name"
              ),
              validator: (text){
                if(text.isEmpty) return "Invalid Name";
              },
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "E-mail"
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (text){
                if(text.isEmpty || !text.contains("@")) return "Invalid E-mail";
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
                if(text.isEmpty || text.length < 6) return "Invalid Password";
              },
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              controller: _adressController,
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

                  Map<String, dynamic> userData ={
                    "name" :_nameController.text,
                    "email": _emailController.text,
                    "address":_adressController.text
                  };

                  model.signUp(
                  userData: userData,
                  pass: _passController.text,
                  onSuccess: _onSuccess, 
                  onFail: _onFail,
                  );
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

  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("User created successfully!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
      )
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Failed on create a user!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
      )
    );
  }
}