import 'package:hive/hive.dart';
part 'quizhistory.g.dart';

@HiveType(typeId: 0)
class QuizHistory {
  @HiveField(0)
  late String quizname;
  @HiveField(1)
  late String score;
  @HiveField(2)
  late String dateTime;
  @HiveField(3)
  late String timetaken;
  QuizHistory(this.quizname, this.score, this.dateTime, this.timetaken);
}


// class QuizHistory {
//   String ?quizname;
//   String ?desc;
// }