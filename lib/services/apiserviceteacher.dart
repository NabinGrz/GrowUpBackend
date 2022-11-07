import 'dart:convert';

import 'package:growup/models/bookedclassesmodel.dart';
import 'package:growup/models/commentmodel.dart';
import 'package:growup/services/apiservice.dart';
import 'package:http/http.dart' as http;

var _ratingResponseData;
var _responseRatingTeacher;
Future postTeacherRating(String teacherId, double rating) async {
  // var response = await http.post(Uri.https('reqres.in', 'api/login'),
  var responseRating =
      await http.post(Uri.https(baseUrlPost, 'api/v1/AddTeacherRating'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $obtainedtokenData',
          },
          body: jsonEncode(
            // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
            <String, dynamic>{
              "StudentId": "0c188464-ba3d-4493-ac40-1ab1de31178c",
              "TeacherId": teacherId,
              "Rating": rating
            },
          ));

  var ratingResponse = responseRating.body;
  print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
  print(ratingResponse);
  if (ratingResponse == "Some properties are not valid") {
    return "Invalid Password";
  } else {
    var data = jsonDecode(responseRating.body); //response after posting
    _ratingResponseData =
        data; //response data, i.e. {"message":"User Created Successfully!","isSuccess":true,"errors":null,"expireDate":null}"
    print("======================================================");
    print(responseRating.statusCode);
    // _responseRatingTeacher = _ratingResponseData.message;
    if (responseRating.statusCode == 200) {
      print("RATING DONE FOR TEACHER");
      return true;
    } else {
      return false;
    }
  }
}

//FOR FGETTING  AVERAGE RATING COUNT OF  TEACHER

var responseRatingCount;
var ratingcount;
Future getAvergaeRatingCountTeacher(String teacherId) async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/GetAverageTeacherRating?teacherId=$teacherId",
  );
  responseRatingCount = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  var data = responseRatingCount.body;
  ratingcount = jsonDecode(data.toString());
  // return ratingcount["average"];
  return ratingcount["average"];
}

//FOR GETTING ALL COMMENTS OF NEWSFEED
var responseComment;
var comments;
Future<List<CommentsModel>> getNewsFeedComments(int newsFeedId) async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/get_comments_of_newsFeed?id=$newsFeedId",
  );
  responseComment = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });

  var data = await responseComment.body;
  comments = commentsModelFromJson(data);
  print("======================AAAAAAAAAAAAAAAAAAAA=======================");
  print(comments);
  return comments;
}

//FOR POSTING COMMENT ON NEWS FEED
var commentResponseData;
var _responseCommenting;
bool commented = false;
Future postComment(String comment, int newsFeedId, String userAppId
    // String zoompassword,
    // String bookingdate,
    // String bookingTime
    ) async {
  // var response = await http.post(Uri.https('reqres.in', 'api/login'),
  var responseCommenting = await http.post(
      Uri.https(baseUrlPost, 'api/v1/addcomment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $obtainedtokenData',
      },
      body: jsonEncode(
          // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
          <String, dynamic>{
            "Description": comment,
            "NewsFeedId": newsFeedId,
            "ApplicationUserId": userAppId
          }));
  if (responseCommenting.statusCode == 200) {
    var commentResponse = responseCommenting.body;
    var data = jsonDecode(commentResponse);
    commented = true;
    _responseCommenting = data;

    return true;
  } else {}

  return false;
}

//FOR GETTING BOOKED CLASSES OF TEACHER
late var myUrl;
late var response;
late var responseBooking;
List<BookedClassesModel>? booking;
Future<List<BookedClassesModel>> getBookedClasses(
    //String teacherId
    String userID) async {
  myUrl = Uri.parse(
    // "$baseUrlGet/api/v1/getbooking",
    //
    "$baseUrlGet/api/v1/teacher/booking?id=$userID",
  );
  responseBooking = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  var data = responseBooking.body;
  booking = bookedClassesModelFromJson(data);
  // video = SkillsVideoResponseModel.fromJson(jsonDecode(data.toString()));
  print("BOOOOOOOOOOOOOOOOOOOOKKED CLASSES");
  print(responseBooking.statusCode);
  print(booking);
  return booking!;
}

//FOR UPDATING PROFILE
var updatingResponseData;
Future updateProfile(
    // String teacherId, String studentId,
    String fullName,
    String gender,
    String address,
    String phoneNumber) async {
  // var response = await http.post(Uri.https('reqres.in', 'api/login'),
  var responseUpdating =
      await http.post(Uri.https(baseUrlPost, 'api/v1/account/update/profile'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $obtainedtokenData',
          },
          body: jsonEncode(
            // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
            <String, dynamic>{
              "FullName": fullName,
              "Gender": gender,
              "Address": address,
              "PhoneNumber": phoneNumber
            },
          ));
  if (responseUpdating.statusCode == 200) {
    var updatingResponse = responseUpdating.body;
    var data = jsonDecode(updatingResponse);
    updatingResponseData = data;
    print("VICTORY HAS BEEN ACHEIVED");
    return true;
  } else {
    return false;
  }
}

late var responseAppID;
late var appID;
//List<TestModel>? usersTestUser = [];
//var finalCount;
//var t ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbWFpbCI6Im5vYmlnMjJAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiIwYzE4ODQ2NC1iYTNkLTQ0OTMtYWM0MC0xYWIxZGUzMTE3OGMiLCJleHAiOjE2NDgwNDg5NDgsImlzcyI6Imh0dHA6Ly9tYWhhcmphbnNhY2hpbi5jb20ubnAiLCJhdWQiOiJodHRwOi8vbWFoYXJqYW5zYWNoaW4uY29tLm5wIn0.1RAi4fzWklh8jyLSMstRrF098RwjxwmXvztAq1rcBWY";
Future<String> getUserAppId() async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/user/id",
  );
  responseAppID = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  if (responseAppID.statusCode == 200) {
    var data = await responseAppID.body;
    appID = jsonDecode(data);
    print("======================VIDEPO=======================");
    print(appID);
    String finalID = await appID["userId"];
    return finalID;
  } else {}
  return appID;
}
