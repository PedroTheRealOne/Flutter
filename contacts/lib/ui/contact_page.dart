import 'package:flutter/material.dart';
import 'package:contacts/helpers/contact_helper.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;

  ContactPage({this.contact});
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  Contact _editedContact;
  bool _userEdited =false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameFocous = FocusNode();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.contact ==null){
      _editedContact =Contact();
    } else {
      _editedContact =Contact.fromMap(widget.contact.toMap());

      _nameController.text =_editedContact.name;
      _phoneController.text =_editedContact.email;
      _emailController.text =_editedContact.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child:
      Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_editedContact.name ?? "New Contact"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_editedContact.name.isNotEmpty && _editedContact.name !=null){
            Navigator.pop(context, _editedContact);
          } else {
            FocusScope.of(context).requestFocus(_nameFocous);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _editedContact.img !=null ? FileImage(File(_editedContact.img)) : AssetImage("images/person.png")
                  ),
                ),
              ),
              onTap: (){
                ImagePicker.pickImage(source: ImageSource.camera).then((file){
                  if(file ==null) return;
                  setState(() {
                    _editedContact.img =file.path;
                  });
                });
              },
            ),
            TextField(
              controller: _nameController,
              focusNode: _nameFocous,
              decoration: InputDecoration(labelText: "Name"),
              onChanged: (text) {
                _userEdited =true;
                setState(() {
                  _editedContact.name =text;
                });
              },
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              onChanged: (text){
                _userEdited = true;
                _editedContact.email = text;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone"),
              onChanged: (text){
                _userEdited = true;
                _editedContact.phone = text;
              },
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),

    )
    );
  }
  Future<bool> _requestPop(){
    if(_userEdited){
      showDialog(context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text("Discart Changes?"),
          content: Text("All alterations will be discarted."),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        );
      }
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}