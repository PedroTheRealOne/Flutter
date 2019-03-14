import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends Model{

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  void signUp({@required Map<String, dynamic> userData, @required String pass, @required VoidCallback onSuccess, @required VoidCallback onFail}){
    isLoading =true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
      email: userData["email"],
      password: pass
    ).then((user) async{
      firebaseUser = user;

      await _saveUserData(userData);

      onSuccess();
      isLoading =false;
      notifyListeners();

    }).catchError((e){

      onFail();
      isLoading =false;
      notifyListeners();

    });

  }

  void singIn(){

  }

  void recoverPass(){

  }

  void singOut() async{
    await _auth.signOut();

    userData = Map();

    firebaseUser = null;

    notifyListeners();
  }


  bool isLoggedIn(){
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async{

    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }
  
}