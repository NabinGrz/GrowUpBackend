import 'dart:convert';

import 'package:growup/services/apiservice.dart';
import 'package:http/http.dart' as http;

var scheduleResponse;
Future<bool> postSchedule(
    String time, String id, String scheduleDateTime) async {
  var responsePostingSchedule =
      await http.post(Uri.https(baseUrlPost, 'api/v1/addschedule'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $obtainedtokenData',
          },
          body: jsonEncode(
              // <String, dynamic>{"NewsFeedUserId": 22, "Rating": 3.5},
              <String, dynamic>{
                "Time": time,
                "ApplicationUserId": id, //
                "ScheduleDateTime": scheduleDateTime
              }));
  if (responsePostingSchedule.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
