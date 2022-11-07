import 'package:flutter/material.dart';
import 'package:growup/adapters/quizhistory.dart';
import 'package:growup/models/quizmodel.dart';
import 'package:growup/screens/quizhistory/quizhistorylist.dart';
import 'package:growup/services/apiservice.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colorpalettes/palette.dart';

class QuizScreen extends StatefulWidget {
  var skillID;
  QuizScreen(this.skillID, {Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState(skillID);
}

class _QuizScreenState extends State<QuizScreen> {
  var skillID;
  _QuizScreenState(this.skillID);
  @override
  var quiz;
  List<String>? k;
  Color answerBoxColors = Colors.white;
  Color correct = Colors.green;
  Color wrong = Colors.red;
  Color notselected = Colors.white;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quiz = getQuiz(widget.skillID);
  }

  PageController pageController = PageController();
  int pageChanged = 0;
  double marks = 0.0;
  double finalMarks = 0.0;
  String quizName = "";
  Map<String, Color> btnColor = {
    "a": const Color.fromARGB(255, 230, 230, 230),
    "b": const Color.fromARGB(255, 230, 230, 230),
    "c": const Color.fromARGB(255, 230, 230, 230),
    "d": const Color.fromARGB(255, 230, 230, 230),
  };
  Map<String, Color> btnTextColor = {
    "a": const Color.fromARGB(255, 0, 0, 0),
    "b": const Color.fromARGB(255, 0, 0, 0),
    "c": const Color.fromARGB(255, 0, 0, 0),
    "d": const Color.fromARGB(255, 0, 0, 0),
  };

  Map<String, double> btnHeight = {
    "a": 60,
    "b": 60,
    "c": 60,
    "d": 60,
  };
  Map<String, double> btnWidth = {
    "a": 400,
    "b": 400,
    "c": 400,
    "d": 400,
  };
  Map<String, double> btnTextSize = {
    "a": 16,
    "b": 16,
    "c": 16,
    "d": 16,
  };
  double buttonH = 60;
  double buttonW = 400;
  checkAnswer(String k, String iscorrect) {
    if (iscorrect == "true") {
      btnColor[k] = Colors.green;
      btnHeight[k] = 65;
      btnWidth[k] = 450;
      btnTextColor[k] = Colors.white;
      btnTextSize[k] = 20;
      marks = marks + 1;

      setState(() {});
      print("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY$marks");
    } else {
      btnColor[k] = wrong;
      btnHeight[k] = 65;
      btnWidth[k] = 450;
      btnTextColor[k] = Colors.white;
      btnTextSize[k] = 20;
      marks = marks;
      setState(() {});
      print("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN$marks");
    }
  }

  giveMessage(int index) {
    String message = "Correct Answer";
    return message;
  }

  Widget choicebutton(String k, String text, String isCorrect) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () {
          checkAnswer(k, isCorrect);
          print("K IS: $k");
        },
        child: Text(
          text,
          style: TextStyle(
            color: btnTextColor[k],
            fontFamily: "Alike",
            fontSize: btnTextSize[k],
          ),
          maxLines: 1,
        ),
        color: btnColor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: btnWidth[k],
        height: btnHeight[k],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          child: FutureBuilder<List<Quiz>>(
              future: quiz,
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data == null ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData ||
                    snapshot.data != null ||
                    snapshot.connectionState == ConnectionState.done) {
                  List<Quiz> listQuiz = snapshot.data;
                  return PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        pageChanged = index;
                      });
                    },
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 12,
                            width: MediaQuery.of(context).size.width - 35,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Color.fromARGB(255, 234, 75, 51),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 212, 212, 212),
                                      blurRadius: 14,
                                      spreadRadius: 2,
                                      offset: Offset(3, 3)),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                listQuiz[index].text.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Color.fromARGB(255, 138, 149, 247),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 212, 212, 212),
                                      blurRadius: 14,
                                      spreadRadius: 2,
                                      offset: Offset(3, 3)),
                                ]),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 2.5,
                              width: MediaQuery.of(context).size.width - 35,
                              child: SingleChildScrollView(
                                physics: const ScrollPhysics(),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: listQuiz[index].options!.length,
                                    itemBuilder: (context, ansIndex) {
                                      k = ['a', 'b', 'c', 'd'];
                                      String selectedAns = listQuiz[index]
                                          .options![ansIndex]
                                          .isCorrectOption
                                          .toString();
                                      return Column(
                                        children: [
                                          choicebutton(
                                              k![ansIndex].toString(),
                                              listQuiz[index]
                                                  .options![ansIndex]
                                                  .text
                                                  .toString(),
                                              selectedAns),
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          index == 7
                              ? ElevatedButton(
                                  onPressed: () {
                                    switch (listQuiz[index].skillId) {
                                      case 1:
                                        {
                                          setState(() {
                                            quizName =
                                                "Android Development Quiz";
                                          });
                                        }
                                        break;

                                      case 2:
                                        {
                                          setState(() {
                                            quizName = "Web Development Quiz";
                                          });
                                        }
                                        break;

                                      case 3:
                                        {
                                          setState(() {
                                            quizName = "Python Quiz";
                                          });
                                        }
                                        break;

                                      case 4:
                                        {
                                          setState(() {
                                            quizName = "Adobe Illustrator Quiz";
                                          });
                                        }
                                        break;
                                      case 5:
                                        {
                                          setState(() {
                                            quizName = "Adobe Photoshop Quiz";
                                          });
                                        }
                                        break;

                                      case 6:
                                        {
                                          setState(() {
                                            quizName = "3d Modelling Quiz";
                                          });
                                        }
                                        break;

                                      case 7:
                                        {
                                          setState(() {
                                            quizName = "Digital Marketing Quiz";
                                          });
                                        }
                                        break;

                                      case 8:
                                        {
                                          setState(() {
                                            quizName =
                                                "Social Media Marketing Quiz";
                                          });
                                        }
                                        break;
                                      case 9:
                                        {
                                          setState(() {
                                            quizName = "Google Ads Quiz";
                                          });
                                        }
                                        break;
                                      default:
                                        {
                                          setState(() {
                                            quizName = "Quiz";
                                          });
                                        }
                                        break;
                                    }
                                    var dateTime = DateTime.now();
                                    Box<QuizHistory> box =
                                        Hive.box<QuizHistory>('history');
                                    box.add(QuizHistory(
                                        quizName,
                                        marks.toString(),
                                        dateTime.toString(),
                                        "2 min"));
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return QuizResultScreen(marks,
                                            listQuiz.length, widget.skillID);
                                      },
                                    ));
                                    // Get.to(QuizResultScreen(marks,
                                    //     listQuiz.length, widget.skillID));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: darkBlueColor,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                      minimumSize: const Size(200, 60)),
                                  child: const Text(
                                    'Finish',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Raleway-Regular',
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    btnColor['a'] = const Color.fromARGB(
                                        255, 230, 230, 230);
                                    btnHeight['a'] = 60;
                                    btnWidth['a'] = 400;
                                    btnTextColor['a'] = Colors.black;
                                    btnTextSize['a'] = 16;
                                    btnColor['b'] = const Color.fromARGB(
                                        255, 230, 230, 230);
                                    btnHeight['b'] = 60;
                                    btnWidth['b'] = 400;
                                    btnTextColor['b'] = Colors.black;
                                    btnTextSize['b'] = 16;
                                    btnColor['c'] = const Color.fromARGB(
                                        255, 230, 230, 230);
                                    btnHeight['c'] = 60;
                                    btnWidth['c'] = 400;
                                    btnTextColor['c'] = Colors.black;
                                    btnTextSize['c'] = 16;
                                    btnColor['d'] = const Color.fromARGB(
                                        255, 230, 230, 230);
                                    btnHeight['d'] = 60;
                                    btnWidth['d'] = 400;
                                    btnTextColor['d'] = Colors.black;
                                    btnTextSize['d'] = 16;
                                    pageController.animateToPage(
                                      ++pageChanged,
                                      duration:
                                          const Duration(milliseconds: 250),
                                      curve: Curves.linear,
                                    );
                                    setState(() {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: darkBlueColor,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                      minimumSize: const Size(280, 60)),
                                  child: const Text(
                                    'Next Question',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Raleway-Regular',
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                        ],
                      );
                    },
                  );
                }
                return Container();
              }),
        ),
      ),
    );
  }
}

class QuizResultScreen extends StatefulWidget {
  static const routeName = '/quizResult';
  var marks;
  var questionNumber;
  var skillID;
  QuizResultScreen(this.marks, this.questionNumber, this.skillID, {Key? key})
      : super(key: key);

  @override
  _QuizResultScreenState createState() =>
      _QuizResultScreenState(marks, questionNumber, skillID);
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  var marks;
  var questionNumber;
  var skillID;
  _QuizResultScreenState(this.marks, this.questionNumber, this.skillID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        //  decoration: ThemeHelper.fullScreenBgBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            quizResultInfo(marks, questionNumber),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bottomTryButtons(),
                bottomHomeButtons(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget bottomTryButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return QuizScreen(widget.skillID);
                },
              ));
            },
            style: ElevatedButton.styleFrom(
                primary: darkBlueColor,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                minimumSize: const Size(200, 60)),
            child: const Text(
              "Try Again",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     // Navigator.pushReplacementNamed(
          //     //     context, QuizHistoryScreen.routeName);
          //   },
          //   child: Text(
          //     "History",
          //     style: TextStyle(color: Colors.white, fontSize: 20),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget bottomHomeButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () async {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.setString("marks", marks.toString());

              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const QuizHistoryListScreen();
                },
              ));
            },
            style: ElevatedButton.styleFrom(
                primary: darkBlueColor,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                minimumSize: const Size(200, 60)),
            child: const Text(
              "Quiz History",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     // Navigator.pushReplacementNamed(
          //     //     context, QuizHistoryScreen.routeName);
          //   },
          //   child: Text(
          //     "History",
          //     style: TextStyle(color: Colors.white, fontSize: 20),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget quizResultInfo(var marks, int questionNumber) {
    return Column(
      children: [
        Image.asset(
          'images/quizResultBadge.png',
          //width: 130,
        ),
        Text(
          "Congratulations!",
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          "You have completed the quiz",
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          "Your Score",
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          "$marks/8",
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}
