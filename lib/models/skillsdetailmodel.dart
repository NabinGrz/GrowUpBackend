// To parse this JSON data, do
//
//     final skillsDetailModel = skillsDetailModelFromJson(jsonString);

import 'dart:convert';

List<SkillsDetailModel> skillsDetailModelFromJson(String str) =>
    List<SkillsDetailModel>.from(
        json.decode(str).map((x) => SkillsDetailModel.fromJson(x)));

String skillsDetailModelToJson(List<SkillsDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SkillsDetailModel {
  SkillsDetailModel({
    this.id,
    this.title,
    this.titleImage,
    this.imageFile,
    this.videos,
    this.skillCategoryId,
  });

  int? id;
  String? title;
  String? titleImage;
  dynamic? imageFile;
  dynamic? videos;
  int? skillCategoryId;

  factory SkillsDetailModel.fromJson(Map<String, dynamic> json) =>
      SkillsDetailModel(
        id: json["id"],
        title: json["title"],
        titleImage: json["titleImage"],
        imageFile: json["imageFile"],
        videos: json["videos"],
        skillCategoryId: json["skillCategoryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "titleImage": titleImage,
        "imageFile": imageFile,
        "videos": videos,
        "skillCategoryId": skillCategoryId,
      };
}
