import 'package:flutter/material.dart';
import 'package:consume/api/Tweet.dart';

class EditTweetView extends StatefulWidget {

  final int id;
  const EditTweetView(this.id);


  @override
  _EditTweetViewState createState() => _EditTweetViewState();
}

class _EditTweetViewState extends State<EditTweetView> {

  

  final _tweetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tweet"),
        centerTitle: true,
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 40),
            child: Column(
              children: <Widget>[_tweetField()],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async{
          print(widget.id);
          Map<String, dynamic> data = {'body': _tweetController.text};
          Tweet().updateTweet(widget.id, data);

          Navigator.pop(context);

          return SnackBar(
            content: Text("Tweet Editado com Sucesso!"),
            action: SnackBarAction(
              label: "Dismiss",
            ),
          );
        },
      ),
    );
  }

  Widget _tweetField() => TextFormField(
        autofocus: true,
        controller: _tweetController,
        decoration: InputDecoration(
          labelText: "Farpas",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      );
}
