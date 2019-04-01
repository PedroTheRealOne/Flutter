import 'package:flutter/material.dart';
import 'package:quantumlabs_flutter_widgets/quantumlabs_flutter_widgets.dart';
import 'package:consume/api/Tweet.dart' as tweetAPI;

class TweetView extends StatefulWidget {
  @override
  _TweetViewState createState() => _TweetViewState();
}

class _TweetViewState extends State<TweetView> {
  var _tweetController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tweet"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
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
        child: Icon(Icons.add),
        onPressed: () {
          if (!_formKey.currentState.validate()) {

          } else {
            
            Map<String, dynamic> data = {"body": _tweetController.text};
            tweetAPI.Tweet().createTweet(data);
          }
        },
      ),
    );
  }

  Widget _tweetField() => TextFormField(
        controller: _tweetController,
        autofocus: true,
        decoration: InputDecoration(
          labelText: "Farpas",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        validator: (value) => ValidationHelper().checkEmpty(value),
      );
}
