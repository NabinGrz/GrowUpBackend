// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

List<QuestionModel> questionModelFromJson(String str) =>
    List<QuestionModel>.from(
        json.decode(str).map((x) => QuestionModel.fromJson(x)));

String questionModelToJson(List<QuestionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionModel {
  QuestionModel({
    this.id,
    this.skillId,
    this.skill,
    this.text,
    this.options,
  });

  int? id;
  int? skillId;
  dynamic? skill;
  String? text;
  dynamic? options;

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json["id"],
        skillId: json["skillId"],
        skill: json["skill"],
        text: json["text"],
        options: json["options"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "skillId": skillId,
        "skill": skill,
        "text": text,
        "options": options,
      };
}
