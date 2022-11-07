// To parse this JSON data, do
//
//     final quiz = quizFromJson(jsonString);

import 'dart:convert';

List<Quiz> quizFromJson(String str) =>
    List<Quiz>.from(json.decode(str).map((x) => Quiz.fromJson(x)));

String quizToJson(List<Quiz> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quiz {
  Quiz({
    this.id,
    this.skillId,
    this.text,
    this.duration,
    this.shuffleOptions,
    this.options,
  });

  int? id;
  int? skillId;
  String? text;
  int? duration;
  bool? shuffleOptions;
  List<Option>? options;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"],
        skillId: json["skillId"],
        text: json["text"],
        duration: json["duration"],
        shuffleOptions: json["shuffleOptions"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "skillId": skillId,
        "text": text,
        "duration": duration,
        "shuffleOptions": shuffleOptions,
        "options": List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  Option({
    this.text,
    this.isCorrectOption,
  });

  String? text;
  bool? isCorrectOption;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        text: json["text"],
        isCorrectOption: json["isCorrectOption"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "isCorrectOption": isCorrectOption,
      };
}
