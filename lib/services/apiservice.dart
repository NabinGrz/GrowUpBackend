import 'dart:convert';
import 'dart:io';
import 'package:growup/models/coursemodel.dart';
import 'package:growup/models/loginmodelresponse.dart';
import 'package:growup/models/newsfeedmodel.dart';
import 'package:growup/models/newsfeedresponsemodel.dart';
import 'package:growup/models/quizmodel.dart';
import 'package:growup/models/registerresponsemodel.dart';
import 'package:growup/models/skillsdetailmodel.dart';
import 'package:growup/models/skillsvideoresponsemodel.dart';
import 'package:growup/models/teachermodel.dart';
import 'package:growup/models/userdetailresponsemodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var obtainedtokenData;
getToken() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  obtainedtokenData = sharedPreferences.getString("tokenData");

  return obtainedtokenData;
}

const baseUrlGet =
    "https://31b3-2400-1a00-b020-164-2195-673c-67b6-414.ngrok.io";
const baseUrlPost = "31b3-2400-1a00-b020-164-2195-673c-67b6-414.ngrok.io";

//===============================================================================

late var myUrl;
late var response;

// Future getUsers() async {
//   myUrl = Uri.parse("https://randomuser.me/api/?page=3&results=5&seed=abc");
//   response = await http.get(myUrl);
//   var data = response.body;
//   users = newsFeedModelFromJson(data);
//
//   return users;
// }

//=================================================================================

//===============================================================================

late var courseUrl;
late var responseCourse;
late List dataCourse;
List<CourseModel>? course;
var _dataCourse;
/*
Future<List<CourseModel>> getCourse({String? query}) async {
  var url = Uri.parse("https://jsonplaceholder.typicode.com/users");
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      usersTutor = data.map((e) => Test.fromJson(e)).toList();
      if (query != null) {
        usersTutor = usersTutor
            .where((element) =>
                element.name!.toLowerCase().contains((query.toLowerCase())))
            .toList();
      }
    } else {
      print("fetch error");
    }
  } on Exception catch (e) {
    print('error: $e');
  }
  return usersTutor;
}
*/

// Future getUsers() async {
//   myUrl = Uri.parse("https://randomuser.me/api/?page=3&results=5&seed=abc");
//   response = await http.get(myUrl);
//   var data = response.body;
//   users = newsFeedModelFromJson(data);
//   return users;
// }

//==================================================================

//================================================================== FOR LOGIN/REGISTRATION
var _loginResponseData;
var responseLoginTokken;
Future login(String email, String password) async {
  // var response = await http.post(Uri.https('reqres.in', 'api/login'),
  var responseLogin =
      await http.post(Uri.http(baseUrlPost, 'api/v1/account/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, dynamic>{
              "Email": email,
              "Password": password,
            },
          ));

  var loginResponse = responseLogin.body;
  print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
  print(loginResponse);
  if (loginResponse == "Some properties are not valid") {
    return "Invalid Password";
  } else {
    var data =
        loginResponseModelFromJson(loginResponse); //response after posting
    _loginResponseData =
        data; //response data, i.e. {"message":"User Created Successfully!","isSuccess":true,"errors":null,"expireDate":null}"
    print("======================================================");
    print(responseLogin.statusCode);
    responseLoginTokken = _loginResponseData;
    if (responseLogin.statusCode == 200) {
      return responseLoginTokken;
    } else {
      return responseLoginTokken;
    }
    print("API CLASS TOKE");
    print(responseLoginTokken);
    return responseLoginTokken;
  }
}

var _registerResponseData;
var _registerResponseMessage;

Future register(String email, String password, String confirmpassword,
    String fullName, String gender, String address, String role) async {
  var responseRegisterString =
      await http.post(Uri.http(baseUrlPost, 'api/v1/account/register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, dynamic>{
              "Email": email,
              "Password": password,
              "ConfirmPassword": confirmpassword,
              "FullName": fullName,
              "Gender": gender,
              "Address": address,
              "Role": role
            },
          ));
//User did not create
  var registerResponse = responseRegisterString.body;
  // if (registerResponse == "Some properties are not valid") {
  //   return "Invalid Password";
  // }
  var data =
      registerResponseModelFromJson(registerResponse); //response after posting
  _registerResponseData =
      data; //response data, i.e. {"message":"User Created Successfully!","isSuccess":true,"errors":null,"expireDate":null}"
  print("======================================================");
  print(responseRegisterString.statusCode);
  _registerResponseMessage = _registerResponseData.message;
  if (_registerResponseMessage == "User did not create") {
    return "Account registered already";
  }
  if (responseRegisterString.statusCode == 200) {
    return _registerResponseMessage;
  } else {}
  return _registerResponseMessage;
}

//=================================================================== FOR GETTING ALL NEWSFEED

late var responseNewsFeed;
late List dataNewsFeed;

List<NewsFeedModel>? newsFeed2;
Future<List<NewsFeedModel>> getNews({String? query}) async {
  //var token = await _Login;
  var url = Uri.parse("$baseUrlGet/api/v1/get_all_newsfeed");
  try {
    var responseNewsFeed = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $obtainedtokenData',
    });
    if (responseNewsFeed.statusCode == 200) {
      dataNewsFeed = await Future.delayed(
          const Duration(seconds: 1), () => json.decode(responseNewsFeed.body));

      newsFeed2 = dataNewsFeed.map((e) => NewsFeedModel.fromJson(e)).toList();

      if (query != null) {
        newsFeed2 = newsFeed2!
            .where((element) => element.applicationUserId!
                .toLowerCase()
                .contains((query.toLowerCase())))
            .toList();
      }
    } else {
      print("fetch error");
    }
  } on Exception catch (e) {
    print('error: $e');
  }
  return newsFeed2!;
}

//FOR FGETTING  ALL NEWSFEED
//responseNewsFeedAvergaeRating
var responseRatingCount;
var ratingcount;
Future getAvergaeRatingCount(int newsfeedId) async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/GetAverageNewsFeedRating?id=$newsfeedId",
  );
  responseRatingCount = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  var data = responseRatingCount.body;
  ratingcount = jsonDecode(data.toString());
  return ratingcount["average"];
}

//FOR GETTING  RATING COUNT OF  NEWSFEED
// var responseRatingCount;
// var ratingcount;
var finalRatingCount;
var responseRatingCountNewsfeed;
var ratingcountnewsfeed;
getRatingCount(int newsfeedId) async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/newsfeed/rating/count?id=$newsfeedId",
  );
  responseRatingCountNewsfeed = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  if (responseRatingCountNewsfeed.statusCode == 200) {
    var responseRating = await responseRatingCountNewsfeed.body;
    var data = await jsonDecode(responseRating);
    ratingcountnewsfeed = await data;
    finalRatingCount = ratingcountnewsfeed;
    return ratingcountnewsfeed;
  } else {}
}

//FOR FGETTING AVERGAE RATING OF NEWSFEED
var _ratingResponseData;
var _responseRating;
Future postNewsFeedRating(int neewsFeedId, double rating) async {
  // var response = await http.post(Uri.https('reqres.in', 'api/login'),
  var responseRating =
      await http.post(Uri.https(baseUrlPost, 'api/v1/AddNewsFeedRating'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $obtainedtokenData',
          },
          body: jsonEncode(
            // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
            <String, dynamic>{
              "NewsFeedId": neewsFeedId,
              "Rating": rating,
            },
          ));

  var ratingResponse = responseRating.body;
  print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
  print(ratingResponse);
  if (ratingResponse == "Some properties are not valid") {
    return "Invalid Password";
  } else {
    var data =
        newsFeedResponseModelFromJson(ratingResponse); //response after posting
    _ratingResponseData =
        data; //response data, i.e. {"message":"User Created Successfully!","isSuccess":true,"errors":null,"expireDate":null}"
    print("======================================================");
    print(responseRating.statusCode);
    _responseRating = _ratingResponseData.message;
    if (responseRating.statusCode == 200) {
      print("RATING DONE");
      return _responseRating;
    } else {}
    print("API CLASS TOKE");
    print(_responseRating);
    return _responseRating;
  }
}

//IMPORTANT
//FOR GETTING USER ALL DETAILS
// var responseRatingCount;
// var ratingcount;
var responseUser;
var userDetail;
Future<UserDetailsResponseModel> getUserDetails(String userId) async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/account/user/detail?id=$userId",
  );
  responseUser = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });

  var data = responseUser.body;
  userDetail = UserDetailsResponseModel.fromJson(jsonDecode(data.toString()));
  print("=============================================");
  print(userDetail.runtimeType);
  return userDetail;
}

//==============================================================FOR GETTING TEACHERS
var responseTeacher;
List? teacherDetail;
List<TeacherModel>? teacher;
Future<List<TeacherModel>> getTeacherDetails({String? query}) async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/account/teachers",
  );
  responseTeacher = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  if (responseTeacher.statusCode == 200) {
    teacherDetail = await Future.delayed(
        const Duration(seconds: 1), () => json.decode(responseTeacher.body));

    teacher = teacherDetail!.map((e) => TeacherModel.fromJson(e)).toList();

    if (query != null) {
      teacher = teacher!
          .where((element) =>
              element.fullName!.toLowerCase().contains((query.toLowerCase())))
          .toList();
    }
  }
  return teacher!;
}

//=========================================================FOR BOOKING TEACHER
//FOR FGETTING AVERGAE RATING OF NEWSFEED
// var _ratingResponseData;
// var _responseRating;
var bookingResponseData;
var _responseBooking;
Future bookTutor(String teacherId, String studentId, String zoomId,
    String zoompassword, String bookingdate, String bookingTime) async {
  // var response = await http.post(Uri.https('reqres.in', 'api/login'),
  var responseBooking =
      await http.post(Uri.https(baseUrlPost, 'api/v1/booking'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $obtainedtokenData',
          },
          body: jsonEncode(
            // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
            <String, dynamic>{
              "TeacherId": teacherId,
              "StudentId": studentId,
              "ZoomId": zoomId,
              //2015-05-16T05:50:06
              "ZoomPassword": zoompassword,
              "BookingDateTime":
                  bookingdate.toString() + "T" + bookingTime.toString()
            },
          ));
  if (responseBooking.statusCode == 200) {
    var bookingResponse = responseBooking.body;
    var data = jsonDecode(bookingResponse);
    _responseBooking = data;

    return true;
  } else {}

  return false;
}

//===================================================FOR COUNTING NO OF VIDEOS AVAILABLE IN SKILLS
late var responseCount;
late var count;
//List<TestModel>? usersTestUser = [];
var finalCount;
Future<int> getVideosCount(int skillID) async {
  myUrl = Uri.parse("$baseUrlGet/api/v1/video/count?id=$skillID");
  responseCount = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  if (responseCount.statusCode == 200) {
    String data = responseCount.body;
    return int.parse(data);
  } else {
    return 0;
  }
}

//=====================================================FOR GETTING SKILLS DETAIL

late var responseSkills;
late var skills;
Future<List<SkillsDetailModel>> getSkillDetails() async {
  print("FINAL TOKEN OF USER:" + obtainedtokenData.toString());
  myUrl = Uri.parse(
    // "$baseUrlGet/api/v1/getskills",
    "$baseUrlGet/api/v1/getskills",
  );
  responseSkills = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  var data = responseSkills.body;
  skills = skillsDetailModelFromJson(data);
  // video = SkillsVideoResponseModel.fromJson(jsonDecode(data.toString()));
  print("=============================================");
  print(userDetail.runtimeType);
  return skills;
}

//===================================================FOR GETTING ALL THE VIDEOS OF SPECIFIC SKILL
// late var responseCount;
// late var count;
late var responseVideo;
List<SkillsVideoResponseModel>? video;
var skillsVideo;
//List<TestModel>? usersTestUser = [];
//var finalCount;
//var t ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbWFpbCI6Im5vYmlnMjJAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiIwYzE4ODQ2NC1iYTNkLTQ0OTMtYWM0MC0xYWIxZGUzMTE3OGMiLCJleHAiOjE2NDgwNDg5NDgsImlzcyI6Imh0dHA6Ly9tYWhhcmphbnNhY2hpbi5jb20ubnAiLCJhdWQiOiJodHRwOi8vbWFoYXJqYW5zYWNoaW4uY29tLm5wIn0.1RAi4fzWklh8jyLSMstRrF098RwjxwmXvztAq1rcBWY";
Future<List<SkillsVideoResponseModel>> getSkillVideos(int skillID) async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/allvideosofskill?id=$skillID",
  );
  responseVideo = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  if (responseVideo.statusCode == 200) {
    var data = await responseVideo.body;
    video = skillsVideoResponseModelFromJson(data);
    // video = SkillsVideoResponseModel.fromJson(jsonDecode(data.toString()));
    print("======================VIDEPO=======================");
    print(video);
    return video!;
  } else {
    return [];
  }
}

//=====================================================F0OR P[OSTING NEWS FEED
var _postNewsFeedData;
var responsePostNewsFeed;
var reponseMessage;
bool postSuccess = false;
Future<bool> postNewsFeed(String title, File file) async {
  var request = http.MultipartRequest(
      "POST", Uri.parse("$baseUrlGet/api/v1/addnewsfeed"));
  request.headers.addAll({
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  request.fields['Title'] = title;
  request.files.add(await http.MultipartFile.fromPath('Image', file.path));
  request.send().then((response) {
    http.Response.fromStream(response).then((onValue) {
      try {
        // get your response here...
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        // handle exeption
      }
      print(postSuccess);
    });
  });
  return true;
//  return reponseMessage;
}

//========================================================================FOR GIVING RATING TO TEACHER BY STUDENTS
var _ratingTeacherData;
var responseRatingTeacher;
Future giveTeacherRating(
  String teacherId,
  String studentId,
  String rating,
) async {
  responseRatingTeacher = await http.post(
      Uri.http('localhost:44394', 'api/v1/AddTeacherRating'),
      body: {"TeacherId": teacherId, "StudentId": studentId, 'Rating': 3.5});
  var data = jsonDecode(responseRatingTeacher.body.toString());
  print(_ratingTeacherData['message']);
  if (responseRatingTeacher.statusCode == 200) {
    responseRatingTeacher = _ratingTeacherData;
  } else {
    // return null;
  }
  return responseRatingTeacher;
}

late var responseQuiz;
late var quiz;
//List<TestModel>? usersTestUser = [];
//var finalCount;
//var t ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbWFpbCI6Im5vYmlnMjJAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiIwYzE4ODQ2NC1iYTNkLTQ0OTMtYWM0MC0xYWIxZGUzMTE3OGMiLCJleHAiOjE2NDgwNDg5NDgsImlzcyI6Imh0dHA6Ly9tYWhhcmphbnNhY2hpbi5jb20ubnAiLCJhdWQiOiJodHRwOi8vbWFoYXJqYW5zYWNoaW4uY29tLm5wIn0.1RAi4fzWklh8jyLSMstRrF098RwjxwmXvztAq1rcBWY";
Future<List<Quiz>> getQuiz(int skillID) async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/all/question?id=$skillID",
  );
  responseQuiz = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  if (responseQuiz.statusCode == 200) {
    var data = await responseQuiz.body;
    quiz = quizFromJson(data);
    print(
        "======================QQQQQQQQQQQQQQQQQQQQQQQQQQ=======================");
    print(quiz);
    return quiz;
  } else {}
  return quiz;
}
