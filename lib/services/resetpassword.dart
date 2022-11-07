import 'dart:convert';

import 'package:growup/services/apiservice.dart';
import 'package:http/http.dart' as http;

Future<bool> forgetPassword(String email) async {
  var responsePassword =
      await http.post(Uri.https(baseUrlPost, 'api/v1/account/forgotpassword'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "email": email,
          }));
  if (responsePassword.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
