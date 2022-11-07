import 'package:hive/hive.dart';
part 'practicerecord.g.dart';

@HiveType(typeId: 2)
class PracticeRecord {
  @HiveField(0)
  late String quizname;
  @HiveField(1)
  late String score;
  @HiveField(2)
  late String dateTime;
  @HiveField(3)
  late String timetaken;
  PracticeRecord(this.quizname, this.score, this.dateTime, this.timetaken);
}


// class PracticeRecord {
//   String ?quizname;
//   String ?desc;
// }