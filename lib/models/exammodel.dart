// To parse this JSON data, do
//
//     final examModel = examModelFromJson(jsonString);

import 'dart:convert';

List<ExamModel> examModelFromJson(String str) =>
    List<ExamModel>.from(json.decode(str).map((x) => ExamModel.fromJson(x)));

String examModelToJson(List<ExamModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExamModel {
  ExamModel({
    this.id,
    this.skillId,
    this.name,
    this.difficulty,
    this.tutorName,
    this.totalQuestions,
  });

  int? id;
  int? skillId;
  String? name;
  String? difficulty;
  String? tutorName;
  int? totalQuestions;

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        id: json["id"],
        skillId: json["skillId"],
        name: json["name"],
        difficulty: json["difficulty"],
        tutorName: json["tutorName"],
        totalQuestions: json["totalQuestions"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "skillId": skillId,
        "name": name,
        "difficulty": difficulty,
        "tutorName": tutorName,
        "totalQuestions": totalQuestions,
      };
}
