import 'dart:convert';

import 'package:growup/models/exammodel.dart';
import 'package:growup/models/testmodel.dart';
import 'package:growup/services/apiservice.dart';
import 'package:http/http.dart' as http;

/**
 https://a57c-27-34-25-117.ngrok.io/api/v1/save/exam
 https://a57c-27-34-25-117.ngrok.io/api/v1/save/test
 https://a57c-27-34-25-117.ngrok.io/api/v1/save/testoption

 https://a57c-27-34-25-117.ngrok.io/api/v1/all/testquestion?id=18
 https://a57c-27-34-25-117.ngrok.io/api/v1/getparticularexam?id=4
 https://a57c-27-34-25-117.ngrok.io/api/v1/all/getallexam

 */

var postingResponse;
Future<bool> postExam(String skillId, String name, String difficulty,
    String tutorname, String totalquestions) async {
  var responsePostingExam =
      await http.post(Uri.https(baseUrlPost, 'api/v1/save/exam'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $obtainedtokenData',
          },
          body: jsonEncode(
              // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
              <String, dynamic>
              // { "SkillId": skillId, "Text": question}

              {
                "SkillId": skillId,
                "Name": name,
                "Difficulty": difficulty,
                "TutorName": tutorname,
                "TotalQuestions": totalquestions
              }));
  if (responsePostingExam.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

var postingTest;
Future<bool> postTest(String question, String examID) async {
  var responsePostingTest =
      await http.post(Uri.https(baseUrlPost, 'api/v1/save/test'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $obtainedtokenData',
          },
          body: jsonEncode(
              // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
              <String, dynamic>{"Question": question, "ExamID": examID}));
  if (responsePostingTest.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

var postingOptions;
Future<bool> postTestOptions(String text, String testID, bool isCorrect) async {
  var responsePostingTest = await http.post(
      Uri.https(baseUrlPost, 'api/v1/save/testoption'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $obtainedtokenData',
      },
      body: jsonEncode(
          // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
          <String, dynamic>{
            "text": text,
            "IsCorrectOption": isCorrect,
            "testID": testID
          }));
  if (responsePostingTest.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

var responseExam;
List<ExamModel>? examData;
Future<List<ExamModel>> getAllExamList() async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/all/getallexam",
  );
  responseExam = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  if (responseExam.statusCode == 200) {
    var data = await responseExam.body;
    examData = examModelFromJson(data);
    return examData!;
  } else {
    return [];
  }
}

var responseTest;
List<TestModel>? testData;
Future<List<TestModel>> getAllTestList(int id) async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/all/testquestion?id=$id",
  );
  responseTest = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  if (responseTest.statusCode == 200) {
    var data = await responseTest.body;
    testData = testModelFromJson(data);
    return testData!;
  } else {
    return [];
  }
}

var responseExamAllTest;
List<TestModel>? examalltest;
Future<List<TestModel>> getAllTestofExam(int id) async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/all/getalltestofexam?examID=$id",
  );
  responseExamAllTest = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $obtainedtokenData',
  });
  if (responseExamAllTest.statusCode == 200) {
    var data = await responseExamAllTest.body;
    examalltest = testModelFromJson(data);
    return examalltest!;
  } else {
    return [];
  }
}
