// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

List<CourseModel> courseModelFromJson(String str) => List<CourseModel>.from(
    json.decode(str).map((x) => CourseModel.fromJson(x)));

String courseModelToJson(List<CourseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseModel {
  CourseModel({
    this.skill,
    this.name,
    this.imageUrl,
    this.noOfVideos,
  });

  String? skill;
  String? name;
  String? imageUrl;
  int? noOfVideos;

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        skill: json["skill"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        noOfVideos: json["noOfVideos"],
      );

  Map<String, dynamic> toJson() => {
        "skill": skill,
        "name": name,
        "imageUrl": imageUrl,
        "noOfVideos": noOfVideos,
      };
}
