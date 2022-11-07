import 'dart:convert';

import 'package:growup/models/categorymodel.dart';
import 'package:growup/models/schedulemodel.dart';
import 'package:growup/services/apiservice.dart';
import 'package:http/http.dart' as http;

var postingResponse;
Future<bool> postQuestion(String skillId, String question) async {
  var responsePostingQuestion =
      await http.post(Uri.https(baseUrlPost, 'api/v1/question'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $obtainedtokenData',
          },
          body: jsonEncode(
              // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
              <String, dynamic>{"SkillId": skillId, "Text": question}));
  if (responsePostingQuestion.statusCode == 200) {
    var response = responsePostingQuestion.body;
    var data = jsonDecode(response);
    postingResponse = data;

    return true;
  } else {
    return false;
  }
}

var postingOptions;
Future postOptions(int skillId, String question, bool isCorrect) async {
  var responsePostingOptions = await http.post(
      Uri.https(baseUrlPost, 'api/v1/option'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $obtainedtokenData',
      },
      body: jsonEncode(
          // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
          <String, dynamic>{
            "text": question,
            "questionId": skillId,
            "isCorrectOption": isCorrect
          }));
  if (responsePostingOptions.statusCode == 200) {
    var response = responsePostingOptions.body;
    var data = jsonDecode(response);
    postingOptions = data;

    return true;
  } else {
    return false;
  }
}

var responseAllSchedules;
List<ScheduleModel>? schedulesLists;
Future<List<ScheduleModel>> getAllScheduleofTeacher(String teacherId) async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/get_teacher_schedule?id=$teacherId",
  );
  responseAllSchedules = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  if (responseAllSchedules.statusCode == 200) {
    var data = await responseAllSchedules.body;
    schedulesLists = scheduleModelFromJson(data);
    return schedulesLists!;
  } else {
    return [];
  }
}

Future<bool> updateSchedule(int id, String scheduleAppId, String scheduleTime,
    String scheduleDate) async {
  Uri url = Uri.parse('$baseUrlGet/api/v1/updateSchedule?id=$id');
  responseAllSchedules = await http.put(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $obtainedtokenData',
      },
      body: json.encode({
        "IsBooked": "True",
        "Time": scheduleTime,
        "ApplicationUserId": scheduleAppId,
        "ScheduleDateTime": scheduleDate
      }));
  if (responseAllSchedules.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

var deleteReponse;
Future<bool> deleteBookings(int id) async {
  Uri url = Uri.parse('$baseUrlGet/api/v1/deleteBooking?id=$id');
  var responseDeleting = await http.delete(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $obtainedtokenData',
    },
  );
  if (responseDeleting.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

var deleteScheduleReponse;
Future<bool> deleteSchedule(int id) async {
  Uri url = Uri.parse('$baseUrlGet/api/v1/deleteSchedule?id=$id');
  var responseDeletingSchedule = await http.delete(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $obtainedtokenData',
    },
  );
  if (responseDeletingSchedule.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> postQuizOptions(String text, String quizID, bool isCorrect) async {
  var responsePostingQuizOptions = await http.post(
      Uri.https(baseUrlPost, 'api/v1/option'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $obtainedtokenData',
      },
      body: jsonEncode(
          // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
          <String, dynamic>{
            "text": text,
            "questionId": quizID,
            "isCorrectOption": isCorrect
          }));
  if (responsePostingQuizOptions.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

var postingTest;
Future<bool> postQuiz(String skillId, String question) async {
  var responsePostingQuiz =
      await http.post(Uri.https(baseUrlPost, 'api/v1/question'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $obtainedtokenData',
          },
          body: jsonEncode(
              // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
              <String, dynamic>{"SkillId": skillId, "Text": question}));
  if (responsePostingQuiz.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

late var responseCategory;
List<CategoryModel>? name;
var skillsVideo;
//List<TestModel>? usersTestUser = [];
//var finalCount;
//var t ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbWFpbCI6Im5vYmlnMjJAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiIwYzE4ODQ2NC1iYTNkLTQ0OTMtYWM0MC0xYWIxZGUzMTE3OGMiLCJleHAiOjE2NDgwNDg5NDgsImlzcyI6Imh0dHA6Ly9tYWhhcmphbnNhY2hpbi5jb20ubnAiLCJhdWQiOiJodHRwOi8vbWFoYXJqYW5zYWNoaW4uY29tLm5wIn0.1RAi4fzWklh8jyLSMstRrF098RwjxwmXvztAq1rcBWY";
Future<List<CategoryModel>> getSkillName(int skillID) async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/categoryname?id=$skillID",
  );
  responseCategory = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  if (responseCategory.statusCode == 200) {
    var data = await responseCategory.body;
    name = categoryModelFromJson(data);
    // video = SkillsVideoResponseModel.fromJson(jsonDecode(data.toString()));
    print("======================VIDEPO=======================");
    print(name);
    return name!;
  } else {
    return [];
  }
}
