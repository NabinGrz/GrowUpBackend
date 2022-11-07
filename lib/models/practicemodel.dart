// To parse this JSON data, do
//
//     final practice = practiceFromJson(jsonString);

import 'dart:convert';

List<Practice> practiceFromJson(String str) =>
    List<Practice>.from(json.decode(str).map((x) => Practice.fromJson(x)));

String practiceToJson(List<Practice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Practice {
  Practice({
    this.skillId,
    this.questions,
  });

  int? skillId;
  List<Question>? questions;

  factory Practice.fromJson(Map<String, dynamic> json) => Practice(
        skillId: json["skillID"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "skillID": skillId,
        "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    this.id,
    this.skill,
    this.text,
    this.options,
  });

  int? id;
  String? skill;
  String? text;
  List<Option>? options;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        skill: json["skill"],
        text: json["text"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "skill": skill,
        "text": text,
        "options": List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  Option({
    this.id,
    this.text,
    this.questionId,
    this.isCorrectOption,
  });

  int? id;
  String? text;
  int? questionId;
  bool? isCorrectOption;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        text: json["text"],
        questionId: json["questionId"],
        isCorrectOption: json["isCorrectOption"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "questionId": questionId,
        "isCorrectOption": isCorrectOption,
      };
}
