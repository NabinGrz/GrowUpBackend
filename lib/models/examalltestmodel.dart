// To parse this JSON data, do
//
//     final examAllTestModel = examAllTestModelFromJson(jsonString);

import 'dart:convert';

List<ExamAllTestModel> examAllTestModelFromJson(String str) =>
    List<ExamAllTestModel>.from(
        json.decode(str).map((x) => ExamAllTestModel.fromJson(x)));

String examAllTestModelToJson(List<ExamAllTestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExamAllTestModel {
  ExamAllTestModel({
    this.id,
    this.question,
    this.examId,
    this.exam,
    this.options,
  });

  int? id;
  String? question;
  int? examId;
  dynamic? exam;
  dynamic? options;

  factory ExamAllTestModel.fromJson(Map<String, dynamic> json) =>
      ExamAllTestModel(
        id: json["id"],
        question: json["question"],
        examId: json["examID"],
        exam: json["exam"],
        options: json["options"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "examID": examId,
        "exam": exam,
        "options": options,
      };
}
