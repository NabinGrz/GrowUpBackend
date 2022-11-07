import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:growup/adapters/quizhistory.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/screens/homescreen/homepage_screen.dart';
import 'package:growup/screens/quizscreen/quiz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';

class QuizHistoryListScreen extends StatefulWidget {
  const QuizHistoryListScreen({Key? key}) : super(key: key);

  @override
  State<QuizHistoryListScreen> createState() => _QuizHistoryListScreenState();
}

class _QuizHistoryListScreenState extends State<QuizHistoryListScreen> {
  var skillID;
  Widget quizHistoryViewItem(QuizHistory quiz) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: whiteColor,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 14,
                  spreadRadius: 2,
                  offset: Offset(3, 3)),
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 10),
              child: SizedBox(
                height: 115,
                width: 10,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: darkBlueColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.quizname.isEmpty ? "Question" : quiz.quizname,
                      style: const TextStyle(fontSize: 24),
                    ),
                    Text("Score: ${quiz.score}/8",
                        style: const TextStyle(
                            color: Colors.redAccent, fontSize: 18)),
                    Text("Time Taken: ${quiz.timetaken}"),
                    Text("Date: ${quiz.dateTime}"),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: darkBlueColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      minimumSize: const Size(120, 45)),
                  onPressed: () {
                    switch (quiz.quizname) {
                      case "Android Development Quiz":
                        {
                          setState(() {
                            skillID = 1;
                          });
                        }
                        break;

                      case "Web Development Quiz":
                        {
                          setState(() {
                            skillID = 2;
                          });
                        }
                        break;

                      case "Python Quiz":
                        {
                          setState(() {
                            skillID = 3;
                          });
                        }
                        break;

                      case "Adobe Illustrator Quiz":
                        {
                          setState(() {
                            skillID = 4;
                          });
                        }
                        break;
                      case "Adobe Photoshop Quiz":
                        {
                          setState(() {
                            skillID = 5;
                          });
                        }
                        break;

                      case "3d Modelling Quiz":
                        {
                          setState(() {
                            skillID = 6;
                          });
                        }
                        break;

                      case "Digital Marketing Quiz":
                        {
                          setState(() {
                            skillID = 7;
                          });
                        }
                        break;

                      case "Social Media Marketing Quiz":
                        {
                          setState(() {
                            skillID = 8;
                          });
                        }
                        break;
                      case "Google Ads Quiz":
                        {
                          setState(() {
                            skillID = 9;
                          });
                        }
                        break;
                      default:
                        {
                          setState(() {
                            skillID = "Quiz";
                          });
                        }
                        break;
                    }
                    Get.to(QuizScreen(skillID));
                  },
                  child: const Text("Start Again")),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Hive.box('history').clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.centerLeft,
              height: 80,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: darkBlueColor,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 14,
                        spreadRadius: 2,
                        offset: Offset(3, 3)),
                  ]),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const HomePageScreen();
                          },
                        ));
                        //Get.to(const HomePageScreen());
                      },
                      icon: Icon(
                        Iconsax.back_square,
                        size: 35,
                        color: whiteColor,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Quiz History",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 30),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<QuizHistory>('history').listenable(),
                  builder: (context, Box<QuizHistory> box, widget) {
                    if (box.values.isEmpty) {
                      return const Center(
                        child: Text("No quiz history"),
                      );
                    } else {}
                    //quizHistoryViewItem()

                    return ListView.builder(
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        QuizHistory? obj = box.getAt(index);
                        return GestureDetector(
                            onLongPress: () {
                              box
                                  .deleteAt(index)
                                  .then((value) => Fluttertoast.showToast(
                                        msg:
                                            "Your quiz history has been deleted",
                                      ));
                            },
                            child: quizHistoryViewItem(obj!));
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
