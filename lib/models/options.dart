// To parse this JSON data, do
//
//     final optionModel = optionModelFromJson(jsonString);

import 'dart:convert';

List<OptionModel> optionModelFromJson(String str) => List<OptionModel>.from(
    json.decode(str).map((x) => OptionModel.fromJson(x)));

String optionModelToJson(List<OptionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OptionModel {
  OptionModel({
    this.id,
    this.text,
    this.questionId,
    this.question,
    this.isCorrectOption,
  });

  int? id;
  String? text;
  int? questionId;
  dynamic? question;
  bool? isCorrectOption;

  factory OptionModel.fromJson(Map<String, dynamic> json) => OptionModel(
        id: json["id"],
        text: json["text"],
        questionId: json["questionId"],
        question: json["question"],
        isCorrectOption: json["isCorrectOption"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "questionId": questionId,
        "question": question,
        "isCorrectOption": isCorrectOption,
      };
}
