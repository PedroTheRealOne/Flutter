import 'dart:convert';
import 'package:consume/services/Http.dart' as http;

class Tweet {
  // Tweet();

  Future<List<dynamic>> getTweets() async {
    final response = await http.get('tweets');
    List<dynamic> tweets = json.decode(response.body);
    return tweets;
  }

  Future<List<dynamic>> getTweetsAsc() async{
    final response = await http.get('tweets/asc');
    List<dynamic> tweetsDesc = json.decode(response.body);
    return tweetsDesc;
  }

  Future<List<dynamic>> getEdits(int id) async {
    final response = await http.get('updates/$id');
    List<dynamic> updates = json.decode(response.body);
    return updates;
  }

  Future<Map<String, dynamic>> createTweet(Map<String, dynamic> data) async {
    final response = await http.post('tweets', data, true);
    Map<String, dynamic> newTweet = json.decode(response.body);
    return newTweet;
  }

  Future<Map<String, dynamic>> likeTweet(Map<String, dynamic> data) async {
    final response = await http.post('likes', data, true);

    try {
      Map<String, dynamic> likedTweet = json.decode(response.body);
      return likedTweet;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, dynamic>> postUpdateTweet(
      Map<String, dynamic> data) async {
    final response = await http.post('updates/', data);

    Map<String, dynamic> updatedTweet = json.decode(response.body);

    return updatedTweet;
  }

  Future<Map<String, dynamic>> updateTweet(
      int id, Map<String, dynamic> data) async {
    final response = await http.put('tweets/$id', data);

    Map<String, dynamic> editTweet = json.decode(response.body);

    return editTweet;
  }

  Future<List<dynamic>> getThisTweet(var idTweet) async {
    final response = await http.get('tweets/$idTweet', true);
    List<dynamic> tweet = json.decode(response.body);
    return tweet;
  }
}
