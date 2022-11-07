// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

List<CommentsModel> commentsModelFromJson(String str) =>
    List<CommentsModel>.from(
        json.decode(str).map((x) => CommentsModel.fromJson(x)));

String commentsModelToJson(List<CommentsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentsModel {
  CommentsModel({
    this.id,
    this.description,
    this.newsFeedId,
    this.newsFeed,
    this.applicationUserId,
    this.applicationUser,
  });

  int? id;
  String? description;
  int? newsFeedId;
  dynamic newsFeed;
  String? applicationUserId;
  dynamic applicationUser;

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        id: json["id"],
        description: json["description"],
        newsFeedId: json["newsFeedId"],
        newsFeed: json["newsFeed"],
        applicationUserId: json["applicationUserId"],
        applicationUser: json["applicationUser"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "newsFeedId": newsFeedId,
        "newsFeed": newsFeed,
        "applicationUserId": applicationUserId,
        "applicationUser": applicationUser,
      };
}
