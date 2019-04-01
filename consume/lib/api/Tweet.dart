import 'dart:convert';
import 'package:consume/services/Http.dart' as http;

class Tweet {
  // Tweet();

  Future<List<dynamic>> getTweets() async {
    final response = await http.get('tweets');
    List<dynamic> tweets = json.decode(response.body);
    return tweets;
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

  Future<Map<String, dynamic>> updateTweet(int id, Map<String, dynamic> data) async{
    final response =await http.put('tweets/$id', data);

    Map<String, dynamic> editTweet = json.decode(response.body);

    return editTweet;
    
  }

  Future<List<dynamic>> getThisTweet(var idTweet, int idUser) async{
    final response = await http.get('tweets/$idTweet', true);
    List<dynamic> tweet = json.decode(response.body);
    return tweet;
  }


}
