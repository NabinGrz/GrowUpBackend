// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

List<ScheduleModel> scheduleModelFromJson(String str) =>
    List<ScheduleModel>.from(
        json.decode(str).map((x) => ScheduleModel.fromJson(x)));

String scheduleModelToJson(List<ScheduleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduleModel {
  ScheduleModel({
    this.id,
    this.isBooked,
    this.scheduleDateTime,
    this.applicationUserId,
    this.application,
    this.time,
  });

  int? id;
  bool? isBooked;
  DateTime? scheduleDateTime;
  String? applicationUserId;
  dynamic application;
  String? time;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json["id"],
        isBooked: json["isBooked"],
        scheduleDateTime: DateTime.parse(json["scheduleDateTime"]),
        applicationUserId: json["applicationUserId"],
        application: json["application"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isBooked": isBooked,
        "scheduleDateTime": scheduleDateTime!.toIso8601String(),
        "applicationUserId": applicationUserId,
        "application": application,
        "time": time,
      };
}
