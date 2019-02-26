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
          Expanded(
            child:
            ListView(
              children: <Widget>[
                ChatMessage(),
                ChatMessage(),
                ChatMessage(),
              ],
            ),
          ),
          Divider(
            height: 1.0,
          ),
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

class ChatMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://scontent.fsjk2-1.fna.fbcdn.net/v/t1.0-9/53311867_1434824966654751_5197044551398719488_o.jpg?_nc_cat=106&_nc_ht=scontent.fsjk2-1.fna&oh=229e10430b526c6b244649bc72cbdddc&oe=5CE251D5"),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Dale", style: Theme.of(context).textTheme.subhead,),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text("Chama no xesq"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

