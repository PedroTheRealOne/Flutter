import 'package:flutter/material.dart';
import 'package:consume/api/Tweet.dart';
import 'package:quantumlabs_flutter_widgets/helpers/DialogHelper.dart';

class EditTweetView extends StatefulWidget {
  final int idTweet;
  final String tweetBody;
  const EditTweetView(this.idTweet, this.tweetBody);

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
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _tweetBodyField(widget.tweetBody),
                  Divider(),
                  _tweetField(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Text(
                      "Histórico: ",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w100,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: Tweet().getEdits(widget.idTweet),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Container();
                    } else {
                      return _createEditTable(snapshot.data);
                    }
                }
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async {
          print(widget.idTweet);
          Map<String, dynamic> data = {'body': _tweetController.text};
          Map<String, dynamic> data2 = {
            'tweetId': widget.idTweet,
            'body': widget.tweetBody
          };
          Tweet().updateTweet(widget.idTweet, data);
          Tweet().postUpdateTweet(data2);
          //DialogHelper(context).showSimpleDialog("Sucesso", "Tweet editado com sucesso!");

          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _createEditTable(List<dynamic> listTweets) => ListView.builder(
        itemCount: listTweets.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Divider(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Conteudo: "),
                        Text(listTweets.elementAt(index)['body'].toString() + ", "),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text("editado em: " + listTweets.elementAt(index)['created_at'].toString(), style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 11,
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
              //Text(listTweets.elementAt(index)['body'].toString())
            ],
          );
        },
      );


  Widget _tweetField() => Container(
        child: TextFormField(
          autofocus: true,
          controller: _tweetController,
          decoration: InputDecoration(
            labelText: "Tweet",
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
      );

  Widget _tweetBodyField(String tweetBody) => Container(
        child: TextFormField(
          enabled: false,
          initialValue: tweetBody,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          )),
        ),
      );
}
