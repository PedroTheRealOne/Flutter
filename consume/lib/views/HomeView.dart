import 'package:flutter/material.dart';
import 'package:quantumlabs_flutter_widgets/quantumlabs_flutter_widgets.dart';
import 'package:consume/api/Tweet.dart' as TweetAPI;
import 'package:consume/widgets/CustomDrawer.dart';
import 'package:consume/views/TweetView.dart';
import 'package:consume/api/Auth.dart';
import 'package:consume/views/EditTweetView.dart';
import 'package:consume/models/Tweet.dart' as tweetMod;


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Tweet Feed"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TweetView()));
        },
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: CustomEdgeInsets().all16lp(),
          ),
          Expanded(
            child: FutureBuilder(
              future: TweetAPI.Tweet().getTweets(),
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
                      return _createABetterTweetTable(
                          snapshot.data); //_createTweetTable(snapshot.data);
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _createABetterTweetTable(List<dynamic> listTweets) => ListView.builder(
        itemCount: listTweets.length,
        reverse: true,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(16, 0, 16, 0)),
              Divider(),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://scontent.fsjk2-1.fna.fbcdn.net/v/t1.0-9/53311867_1434824966654751_5197044551398719488_o.jpg?_nc_cat=106&_nc_ht=scontent.fsjk2-1.fna&oh=9ae96482ce308ba32a713bd83d78cefd&oe=5D09DED5"),
                            fit: BoxFit.fitWidth)),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            "@" +
                                listTweets
                                    .elementAt(index)["user"][0]["username"]
                                    .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 4, 0, 0),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 4, 16, 0),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0, color: Colors.white)),
                            child: Text(listTweets.elementAt(index)["body"],
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                child: Icon(Icons.favorite),
                                onTap: () {
                                  Map<String, dynamic> data = {
                                    "tweetId": listTweets.elementAt(index)['id']
                                  };
                                  TweetAPI.Tweet().likeTweet(data);
                                },
                              ),
                              VerticalDivider(),
                              GestureDetector(
                                child: Icon(Icons.edit),
                                onTap: () async{

                                  Map<String, dynamic> idTweet = {'tweetId' : listTweets.elementAt(index)['id']};
                                  Map<String, dynamic> idUser = {'userId': listTweets.elementAt(index)['user_id']};
                                  Map<String, dynamic> user = await Auth().isLogged();

                                  var _idTweet = idTweet.values.toList();
                                  var _idUser = idUser.values.toList();

                                  if(user['user']['id'] == _idUser[0]){
                                  Future<List<dynamic>> tweet = TweetAPI.Tweet().getThisTweet(_idTweet[0], _idUser[0]);

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditTweetView(_idTweet[0])));

                                  } else {
                                    return new SnackBar(
                                      content: Text("Sem permissao irmao"),
                                      action: SnackBarAction(
                                        label: "dismiss",
                                        onPressed: (){},
                                      ),
                                    );
                                  }
                                },
                              ),
                              VerticalDivider(),
                              GestureDetector(
                                child: Icon(Icons.share),
                                onTap: () {},
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
}
