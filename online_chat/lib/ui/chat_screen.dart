import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Online Chat"),
          centerTitle: true,
          elevation: Theme.of(context).platform ==TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: TextComposer(),
            )
          ],
        ),
      ),
    );
  }
}

class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: Theme.of(context).platform ==TargetPlatform.iOS ?
        BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[200]))
        ) :
        null,
      
      child: Row(
        children: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () {},
            )
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(hintText: "Send a message"),
              onChanged: (text){
                setState(() {
                  _isComposing =text.length > 0;
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Theme.of(context).platform ==TargetPlatform.iOS ? CupertinoButton(
              child: Text("Send"),
              onPressed: _isComposing
              ? (){}
              : null,
            )
            
            :
            IconButton(
              icon:Icon(Icons.send),
              onPressed: _isComposing
              ? (){}
              :null,

            )
          ),
        ],
      ),
      ),
    );
  }
}

