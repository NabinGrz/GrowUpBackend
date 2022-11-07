import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:growup/services/apiservice.dart';

var _ratingResponseData;
var _responseRating;
Future<bool> postVideoRating(String appID, int videoID, double rating) async {
  // var response = await http.post(Uri.https('reqres.in', 'api/login'),
  var responseRating =
      await http.post(Uri.https(baseUrlPost, 'api/v1/AddVideoRating'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $obtainedtokenData',
          },
          body: jsonEncode(
            // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
            <String, dynamic>{
              "ApplicationUserId": appID,
              "VideoId": videoID,
              "Rating": rating
            },
          ));

  if (responseRating.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

var responseVideoRatingCount;
var ratingcount;
Future getAvergaeVideoRatingCount(int videoID) async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/GetAverageVideoRating?videoId=$videoID",
  );
  responseVideoRatingCount = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  var data = responseVideoRatingCount.body;
  ratingcount = jsonDecode(data.toString());
  return ratingcount["average"];
}
