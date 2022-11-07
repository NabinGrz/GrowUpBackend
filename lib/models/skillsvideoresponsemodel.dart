// To parse this JSON data, do
//
//     final skillsVideoResponseModel = skillsVideoResponseModelFromJson(jsonString);

import 'dart:convert';

List<SkillsVideoResponseModel> skillsVideoResponseModelFromJson(String str) =>
    List<SkillsVideoResponseModel>.from(
        json.decode(str).map((x) => SkillsVideoResponseModel.fromJson(x)));

String skillsVideoResponseModelToJson(List<SkillsVideoResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SkillsVideoResponseModel {
  SkillsVideoResponseModel({
    this.id,
    this.videoName,
    this.videoUrl,
    this.imageUrl,
    this.video,
    this.skillId,
    this.skill,
    this.rating,
  });

  int? id;
  String? videoUrl;
  String? videoName;
  String? imageUrl;
  dynamic video;
  int? skillId;
  dynamic? skill;
  double? rating;

  factory SkillsVideoResponseModel.fromJson(Map<String, dynamic> json) =>
      SkillsVideoResponseModel(
        id: json["id"],
        videoName: json["videoName"],
        videoUrl: json["videoUrl"],
        imageUrl: json["imageUrl"],
        video: json["video"],
        skillId: json["skillId"],
        skill: json["skill"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "videoName": videoName,
        "videoUrl": videoUrl,
        "imageUrl": imageUrl,
        "video": video,
        "skillId": skillId,
        "skill": skill,
        "rating": rating,
      };
}
