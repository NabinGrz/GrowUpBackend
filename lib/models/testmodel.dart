// To parse this JSON data, do
//
//     final testModel = testModelFromJson(jsonString);

import 'dart:convert';

List<TestModel> testModelFromJson(String str) =>
    List<TestModel>.from(json.decode(str).map((x) => TestModel.fromJson(x)));

String testModelToJson(List<TestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestModel {
  TestModel({
    this.id,
    this.question,
    this.examId,
    this.exam,
    this.options,
  });

  int? id;
  String? question;
  int? examId;
  dynamic exam;
  List<Option>? options;

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        id: json["id"],
        question: json["question"],
        examId: json["examID"],
        exam: json["exam"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "examID": examId,
        "exam": exam,
        "options": List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  Option({
    this.id,
    this.text,
    this.testId,
    this.isCorrectOption,
  });

  int? id;
  String? text;
  int? testId;
  bool? isCorrectOption;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        text: json["text"],
        testId: json["testID"],
        isCorrectOption: json["isCorrectOption"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "testID": testId,
        "isCorrectOption": isCorrectOption,
      };
}
