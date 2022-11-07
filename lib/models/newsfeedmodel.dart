// To parse this JSON data, do
//
//     final newsFeedModel = newsFeedModelFromJson(jsonString);

import 'dart:convert';

List<NewsFeedModel> newsFeedModelFromJson(String str) =>
    List<NewsFeedModel>.from(
        json.decode(str).map((x) => NewsFeedModel.fromJson(x)));

String newsFeedModelToJson(List<NewsFeedModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsFeedModel {
  NewsFeedModel({
    this.id,
    this.title,
    this.imageUrl,
    this.image,
    this.applicationUserId,
    this.application,
  });

  int? id;
  String? title;
  String? imageUrl;
  dynamic? image;
  String? applicationUserId;
  dynamic? application;

  factory NewsFeedModel.fromJson(Map<String, dynamic> json) => NewsFeedModel(
        id: json["id"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        image: json["image"],
        applicationUserId: json["applicationUserId"],
        application: json["application"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageUrl": imageUrl,
        "image": image,
        "applicationUserId": applicationUserId,
        "application": application,
      };
}
