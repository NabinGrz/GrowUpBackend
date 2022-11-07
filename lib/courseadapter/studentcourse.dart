import 'package:hive/hive.dart';
part 'studentcourse.g.dart';

@HiveType(typeId: 1)
class StudentCourse {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String imageUrl;
  @HiveField(2)
  late String noOfVideos;
  @HiveField(3)
  late String skillId;
  StudentCourse(this.name, this.imageUrl, this.noOfVideos, this.skillId);
}


// class StudentCourse {
//   String ?name;
//   String ?desc;
// }