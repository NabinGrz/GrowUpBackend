// To parse this JSON data, do
//
//     final bookedClassesModel = bookedClassesModelFromJson(jsonString);

import 'dart:convert';

List<BookedClassesModel> bookedClassesModelFromJson(String str) =>
    List<BookedClassesModel>.from(
        json.decode(str).map((x) => BookedClassesModel.fromJson(x)));

String bookedClassesModelToJson(List<BookedClassesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookedClassesModel {
  BookedClassesModel({
    this.id,
    this.teacherId,
    this.studentId,
    this.zoomId,
    this.zoomPassword,
    this.bookingDateTime,
  });

  int? id;
  String? teacherId;
  String? studentId;
  String? zoomId;
  String? zoomPassword;
  DateTime? bookingDateTime;

  factory BookedClassesModel.fromJson(Map<String, dynamic> json) =>
      BookedClassesModel(
        id: json["id"],
        teacherId: json["teacherId"],
        studentId: json["studentId"],
        zoomId: json["zoomId"],
        zoomPassword: json["zoomPassword"],
        bookingDateTime: DateTime.parse(json["bookingDateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teacherId": teacherId,
        "studentId": studentId,
        "zoomId": zoomId,
        "zoomPassword": zoomPassword,
        "bookingDateTime": bookingDateTime!.toIso8601String(),
      };
}
