import 'package:growup/models/questions.dart';
import 'package:http/http.dart' as http;
import 'package:growup/services/apiservice.dart';

late var responseQuestions;
var dataQuestions;
var t =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbWFpbCI6ImtjLnN1aGFudEBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjE2ZjhiNzJhLTgzNTktNDEwYi04Y2JlLTAwN2NhMDViZDQ3MiIsImV4cCI6MTY1MTQwMTY5NiwiaXNzIjoiaHR0cDovL21haGFyamFuc2FjaGluLmNvbS5ucCIsImF1ZCI6Imh0dHA6Ly9tYWhhcmphbnNhY2hpbi5jb20ubnAifQ.A90fMhg-DDrglQ8FjAyqC1eohksodxiaCeDsk4iaVVA";
var newsFeed2;
Future<List<QuestionModel>> getAllTestQuestion() async {
  myUrl = Uri.parse(
    "$baseUrlGet/api/v1/all/questionall",
  );
  responseQuestions = await http.get(myUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $t',
    //'Authorization': 'Bearer $obtainedtokenData',
  });
  if (responseQuestions.statusCode == 200) {
    var data = await responseQuestions.body;
    dataQuestions = questionModelFromJson(data);

    return dataQuestions;
  } else {
    return [];
  }
  // return dataQuestions;
}
