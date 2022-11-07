import 'dart:convert';

import 'package:http/http.dart' as http;

var _videoData;
var responseVideos;
Future register(
    //for Adding Videos in skills
    String email,
    String password,
    String fullName,
    String role) async {
  // var response = await http.post(Uri.https('reqres.in', 'api/login'),https://localhost:44394/api/v1/video
  responseVideos =
      await http.post(Uri.http('localhost:44394', 'api/v1/video'), body: {
    "Video": fullName,
    "VideoUrl": "Basic Training3",
    'SkillId': 7,
    'Rating': 3.5,
    'Skill': "Design"
  });
  var data = jsonDecode(responseVideos.body.toString());
  // _videoData = registerModelFromJson(data);
  print(_videoData['message']);
  if (responseVideos.statusCode == 200) {
    responseVideos = _videoData;
  } else {
    // return null;
  }
  return responseVideos;
}

//=============================================================================

