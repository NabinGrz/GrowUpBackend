// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) =>
    json.encode(data.toJson());

class RegisterResponseModel {
  RegisterResponseModel({
    this.message,
    this.isSuccess,
    this.errors,
    this.expireDate,
  });

  String? message;
  bool? isSuccess;
  dynamic errors;
  dynamic expireDate;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
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
