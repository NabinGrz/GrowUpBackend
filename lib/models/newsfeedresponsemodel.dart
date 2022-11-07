// To parse this JSON data, do
//
//     final newsFeedResponseModel = newsFeedResponseModelFromJson(jsonString);

import 'dart:convert';

NewsFeedResponseModel newsFeedResponseModelFromJson(String str) =>
    NewsFeedResponseModel.fromJson(json.decode(str));

String newsFeedResponseModelToJson(NewsFeedResponseModel data) =>
    json.encode(data.toJson());

class NewsFeedResponseModel {
  NewsFeedResponseModel({
    this.message,
    this.isSuccess,
    this.errors,
    this.expireDate,
  });

  String? message;
  bool? isSuccess;
  dynamic? errors;
  dynamic? expireDate;

  factory NewsFeedResponseModel.fromJson(Map<String, dynamic> json) =>
      NewsFeedResponseModel(
        message: json["message"],
        isSuccess: json["isSuccess"],
        errors: json["errors"],
        expireDate: json["expireDate"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isSuccess": isSuccess,
        "errors": errors,
        "expireDate": expireDate,
      };
}
