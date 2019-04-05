import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:quantumlabs_flutter_widgets/quantumlabs_flutter_widgets.dart';
import 'package:consume/api/Tweet.dart' as TweetAPI;
import 'package:consume/views/TweetView.dart';
import 'package:consume/api/Auth.dart';
import 'package:consume/views/EditTweetView.dart';
import 'package:consume/views/LoginView.dart';
import 'package:share/share.dart';
import 'package:consume/views/FavTweetView.dart';
import 'package:date_format/date_format.dart';

class HomeView extends StatefulWidget {
  final int idUser;
  const HomeView([this.idUser]);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool flagSort;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tweet Feed"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavTweetView()));
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_upward),
            onPressed: () async {
              List<dynamic> listTweets;
              listTweets = await TweetAPI.Tweet().getTweetsAsc();
              setState(() {
                flagSort = true;
                return _createTweetTableAsc(listTweets, widget.idUser);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_downward),
            onPressed: () {
              setState(() {
                flagSort = false;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await Auth().logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
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
                      if (flagSort == false) {
                        return _createABetterTweetTable(
                          snapshot.data,
                          widget.idUser,
                        );
                      } else {
                        return _createTweetTableAsc(
                            snapshot.data, widget.idUser);
                      }
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createABetterTweetTable(List<dynamic> listTweets, int id) =>
      ListView.builder(
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "@" +
                                    listTweets
                                        .elementAt(index)["user"][0]["username"]
                                        .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "    at: " +
                                    _convertDateFromString(listTweets
                                            .elementAt(index)['created_at'])
                                        .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 11,
                                ),
                              ),
                            ],
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
                            child: _likedTweeet(listTweets, index, widget.idUser),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Row(
                            children: <Widget>[
                              _likeIcon(listTweets, index, widget.idUser),
                              VerticalDivider(),
                              _editIcon(listTweets, index, widget.idUser),
                              VerticalDivider(
                                color: Colors.yellow,
                              ),
                              GestureDetector(
                                child: Icon(Icons.share),
                                onTap: () async {
                                  await Auth().isLogged();

                                  Map<String, dynamic> userName = {
                                    'userId': listTweets
                                        .elementAt(index)['user'][0]['username']
                                  };
                                  Map<String, dynamic> tweetBody = {
                                    'userId':
                                        listTweets.elementAt(index)['body']
                                  };

                                  var _username = userName.values.toList()[0];
                                  var _tweetBody = tweetBody.values.toList()[0];

                                  _convertDateFromString(listTweets
                                      .elementAt(index)['created_at']);

                                  Share.share(
                                      "Tweet de @$_username: \n $_tweetBody");
                                },
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

  _convertDateFromString(String date) {
    DateTime tweetDate = DateTime.parse(date);
    return (formatDate(
        tweetDate, [dd, '/', mm, '/', yyyy, ' ', hh, ':', nn, '', ' ', am]));
  }

  _verLike(List<dynamic> listTweets, int index, int id) {
    int i = 0;
    int size;
    size = listTweets.elementAt(index)['likes'].length;
    if (size > 0) {
      while (i < size) {
        if (listTweets.elementAt(index)['likes'][i]['user_id'] == id) {
          return Icon(Icons.favorite);
        } else {
          i++;
        }
      }
      return Icon(Icons.favorite_border);
    } else {
      return Icon(Icons.favorite_border);
    }
  }

  Widget _likeIcon(List<dynamic> listTweets, int index, int id) =>
      GestureDetector(
        child: _verLike(listTweets, index, id),
        onTap: () {
          Map<String, dynamic> data = {
            "tweetId": listTweets.elementAt(index)['id']
          };
          TweetAPI.Tweet().likeTweet(data);

          setState(() {
            _verLike(listTweets, index, id);
          });
        },
      );

  _verEdit(List<dynamic> listTweets, int index, int id) {
    int i = 0;
    int size;
    size = listTweets.length;
    if (size > 0) {
      while (i < size) {
        if (listTweets.elementAt(index)['user_id'] == id) {
          return Icon(Icons.edit);
        } else {
          i++;
        }
      }
      return Icon(
        Icons.edit,
        color: Color.fromRGBO(255, 135, 135, 0.5),
      );
    } else {
      return Icon(
        Icons.edit,
        color: Color.fromRGBO(255, 135, 135, 0.5),
      );
    }
  }

  Widget _editIcon(List<dynamic> listTweets, int index, int id) =>
      GestureDetector(
        child: _verEdit(listTweets, index, id),
        onTap: () async {
          Map<String, dynamic> idTweet = {
            'tweetId': listTweets.elementAt(index)['id']
          };
          Map<String, dynamic> idUser = {
            'userId': listTweets.elementAt(index)['user_id']
          };
          Map<String, dynamic> user = await Auth().isLogged();
          Map<String, dynamic> tweetBody = {
            'body': listTweets.elementAt(index)['body']
          };

          var _idTweet = idTweet.values.toList();
          var _idUser = idUser.values.toList();
          var _tweetBody = tweetBody.values.toList();

          if (user['user']['id'] == _idUser[0]) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditTweetView(_idTweet[0], _tweetBody[0])));
          } else {
            DialogHelper(context).showSimpleDialog(
                "Erro", "Você não tem permissão para alterar esse tweet");
          }
        },
      );

  _likedTweeet(List<dynamic> listTweets, int index, int id) {
    int i = 0;
    int size;
    size = listTweets.elementAt(index)['likes'].length;
    if (size > 0) {
      while (i < size) {
        if (listTweets.elementAt(index)['likes'][i]['user_id'] == id) {
          return Text(
            listTweets.elementAt(index)["body"].toString(),
            style: TextStyle(
                fontSize: 14, color: Color.fromRGBO(255, 51, 51, 2.0)),
          );
        } else {
          i++;
        }
      }
      return Text(
        listTweets.elementAt(index)["body"].toString(),
        style: TextStyle(
          fontSize: 14,
        ),
      );
    } else {
      return Text(
        listTweets.elementAt(index)["body"].toString(),
        style: TextStyle(
          fontSize: 14,
        ),
      );
    }
  }

  Widget _createTweetTableAsc(List<dynamic> listTweets, int id) =>
      ListView.builder(
        itemCount: listTweets.length,
        reverse: false,
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "@" +
                                    listTweets
                                        .elementAt(index)["user"][0]["username"]
                                        .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "    at: " +
                                    _convertDateFromString(listTweets
                                            .elementAt(index)['created_at'])
                                        .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 11,
                                ),
                              ),
                            ],
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
                            child:
                                _likedTweeet(listTweets, index, widget.idUser),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Row(
                            children: <Widget>[
                              _likeIcon(listTweets, index, widget.idUser),
                              VerticalDivider(),
                              _editIcon(listTweets, index, widget.idUser),
                              VerticalDivider(
                                color: Colors.yellow,
                              ),
                              GestureDetector(
                                child: Icon(Icons.share),
                                onTap: () async {
                                  await Auth().isLogged();

                                  Map<String, dynamic> userName = {
                                    'userId': listTweets
                                        .elementAt(index)['user'][0]['username']
                                  };
                                  Map<String, dynamic> tweetBody = {
                                    'userId':
                                        listTweets.elementAt(index)['body']
                                  };

                                  var _username = userName.values.toList()[0];
                                  var _tweetBody = tweetBody.values.toList()[0];

                                  _convertDateFromString(listTweets
                                      .elementAt(index)['created_at']);

                                  Share.share(
                                      "Tweet de @$_username: \n $_tweetBody");
                                },
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
