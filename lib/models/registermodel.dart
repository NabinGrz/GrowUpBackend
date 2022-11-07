// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    this.email,
    this.password,
    this.confirmPassword,
    this.fullName,
    this.gender,
    this.address,
    this.role,
  });

  String? email;
  String? password;
  String? confirmPassword;
  String? fullName;
  String? gender;
  String? address;
  String? role;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        email: json["Email"],
        password: json["Password"],
        confirmPassword: json["ConfirmPassword"],
        fullName: json["FullName"],
        gender: json["Gender"],
        address: json["Address"],
        role: json["Role"],
      );

  Map<String, dynamic> toJson() => {
        "Email": email,
        "Password": password,
        "ConfirmPassword": confirmPassword,
        "FullName": fullName,
        "Gender": gender,
        "Address": address,
        "Role": role,
      };
}
