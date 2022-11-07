import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:growup/adapters/practicerecord.dart';
import 'package:growup/models/practicemodel.dart';
import 'package:growup/screens/homescreen/homepage_screen.dart';
import 'package:growup/screens/practicerecord/practicerecordscree.dart';
import 'package:growup/services/apipractice.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import '../../colorpalettes/palette.dart';
import 'package:pdf/widgets.dart' as pw;

_showModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: MediaQuery.of(context).size.height / 2.4,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xffFFFFFF),
              // borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Iconsax.box_remove,
                  size: 120,
                  color: Colors.red,
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "End practice session?",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Text(
                      "Are you sure you want to exit the practice session?",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 66, 66, 66)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    //print("Time is:" + timer.toString());
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: darkBlueColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(150, 60)),
                  child: const Text(
                    'Resume',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Raleway-Regular',
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const HomePageScreen());
                  },
                  child: SizedBox(
                    height: 40,
                    child: Text(
                      "Quit",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: darkBlueColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

class PracticeQuestionScreen extends StatefulWidget {
  var skillID;
  PracticeQuestionScreen(this.skillID, {Key? key}) : super(key: key);

  @override
  State<PracticeQuestionScreen> createState() =>
      _PracticeQuestionScreenState(skillID);
}

class _PracticeQuestionScreenState extends State<PracticeQuestionScreen> {
  var skillID;
  _PracticeQuestionScreenState(this.skillID);
  bool isClicked = false;
  @override
  var practiceQuestions;
  List<String>? k;
  int timer = 0;
  String showtimer = "0";
  Color answerBoxColors = Colors.white;
  Color correct = const Color.fromARGB(255, 255, 215, 17);
  Color wrong = const Color.fromARGB(255, 232, 15, 0);
  bool canceltimer = false;
  Color notselected = Colors.white;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    starttimer();
    // practiceQuestions = getPractice(widget.skillID);
    practiceQuestions = getPracticeQuestions();
  }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        // if (timer < 1) {
        //   t.cancel();
        //   nextPage();
        // } else if (canceltimer == true) {
        //   t.cancel();
        if (timer == 90) {
        } else {
          timer = timer + 1;
        }
        showtimer = timer.toString().length == 2
            ? timer.toString()
            : "0" + timer.toString();
      });
    });
  }

  void nextPage() {
    pageController.animateToPage(
      ++pageChanged,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }

  PageController pageController = PageController();
  int pageChanged = 0;
  double marks = 0.0;
  double finalMarks = 0.0;
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
    "a": 20,
    "b": 20,
    "c": 20,
    "d": 20,
  };
  Map<String, double> btnWidth = {
    "a": 20,
    "b": 20,
    "c": 20,
    "d": 20,
  };
  Map<String, double> btnTextSize = {
    "a": 16,
    "b": 16,
    "c": 16,
    "d": 16,
  };
  double buttonH = 20;
  double buttonW = 20;
  // a dcoument variable decalration
  final doc = pw.Document();

  checkAnswer(String k, String iscorrect) {
    if (iscorrect == "true") {
      btnColor[k] = Colors.green;
      btnHeight[k] = 23;
      btnWidth[k] = 23;
      btnTextColor[k] = Colors.white;
      btnTextSize[k] = 23;
      marks = marks + 1;

      setState(() {});
      print("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY$marks");
    } else {
      btnColor[k] = wrong;
      btnHeight[k] = 23;
      btnWidth[k] = 23;
      btnTextColor[k] = Colors.white;
      btnTextSize[k] = 23;
      marks = marks;
      setState(() {});
      print("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN$marks");
    }
  }

  giveMessage(int index) {
    String message = "Correct Answer";
    return message;
  }

  Widget choicebutton(String k, String isCorrect) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () {
          checkAnswer(k, isCorrect);
          print("K IS: $k");
          setState(() {
            isClicked = true;
          });
        },
        child: Container(),
        color: btnColor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: btnWidth[k],
        height: btnHeight[k],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: darkBlueColor,
          body: FutureBuilder<List<Practice>>(
              future: practiceQuestions,
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data == null ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData ||
                    snapshot.data != null ||
                    snapshot.connectionState == ConnectionState.done) {
                  List<Practice> listPractice = snapshot.data;
                  return PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        pageChanged = index;
                      });
                    },
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listPractice[widget.skillID - widget.skillID]
                        .questions!
                        .length,
                    itemBuilder: (context, index) {
                      var num = index + 1;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              //color: Colors.red,
                              width: MediaQuery.of(context).size.width - 17,
                              height: MediaQuery.of(context).size.height * 0.11,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "00:" + showtimer,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _showModalBottomSheet(context);
                                    },
                                    child: const Text(
                                      "END",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Color.fromARGB(255, 254, 162, 87),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 111, 115, 143),
                                      blurRadius: 14,
                                      spreadRadius: 1,
                                      offset: Offset(3, 3)),
                                ]),
                            height: MediaQuery.of(context).size.height / 1.8,
                            width: MediaQuery.of(context).size.width - 20,
                            child: Column(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Question $num :",
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 27),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          listPractice[widget.skillID -
                                                  widget.skillID]
                                              .questions![index]
                                              .text
                                              .toString(),
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  width: MediaQuery.of(context).size.width - 35,
                                  // color: Colors.red,
                                  child: SingleChildScrollView(
                                    physics: const ScrollPhysics(),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: listPractice[
                                                widget.skillID - widget.skillID]
                                            .questions![index]
                                            .options!
                                            .length,
                                        itemBuilder: (context, ansIndex) {
                                          k = ['a', 'b', 'c', 'd'];
                                          String selectedAns = listPractice[
                                                  widget.skillID -
                                                      widget.skillID]
                                              .questions![index]
                                              .options![ansIndex]
                                              .isCorrectOption
                                              .toString();
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  choicebutton(
                                                      k![ansIndex].toString(),
                                                      selectedAns),
                                                  SizedBox(
                                                    //color: Colors.red,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            150,
                                                    height: 50,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12.0),
                                                      child: Text(
                                                        listPractice[widget
                                                                    .skillID -
                                                                widget.skillID]
                                                            .questions![index]
                                                            .options![ansIndex]
                                                            .text
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                        ),
                                                        //textAlign: TextAlign.left,
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          isClicked
                              ? index ==
                                      listPractice[widget.skillID -
                                                  widget.skillID]
                                              .questions!
                                              .length -
                                          1
                                  ? Container(
                                      width: 150,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xffFE876C),
                                            Color(0xffFD5D37),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          30.0,
                                        ),
                                      ),
                                      child: FlatButton(
                                        onPressed: () {
                                          var datetime = DateTime.now();
                                          Box<PracticeRecord> box =
                                              Hive.box<PracticeRecord>(
                                                  'practice');
                                          print(
                                              "==============================================");
                                          print(box.length);
                                          box.length;
                                          box.add(PracticeRecord(
                                              listPractice[widget.skillID -
                                                      widget.skillID]
                                                  .questions![0]
                                                  .skill
                                                  .toString(),
                                              marks.toString(),
                                              datetime.toString(),
                                              "$timer Sec"));
                                          Get.to(
                                              const PracticeRecordListScreen());
                                          Fluttertoast.showToast(
                                            msg:
                                                "Good jon you have cleard the practice",
                                          );
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                        child: Text(
                                          'Finish',
                                          style: whiteTextStyle.copyWith(
                                              fontSize: 18),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 150,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xffFE876C),
                                            Color(0xffFD5D37),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          30.0,
                                        ),
                                      ),
                                      child: FlatButton(
                                        onPressed: () {
                                          btnColor['a'] = const Color.fromARGB(
                                              255, 230, 230, 230);
                                          btnHeight['a'] = 23;
                                          btnWidth['a'] = 23;
                                          btnTextColor['a'] = Colors.black;
                                          btnTextSize['a'] = 16;
                                          btnColor['b'] = const Color.fromARGB(
                                              255, 230, 230, 230);
                                          btnHeight['b'] = 23;
                                          btnWidth['b'] = 23;
                                          btnTextColor['b'] = Colors.black;
                                          btnTextSize['b'] = 16;
                                          btnColor['c'] = const Color.fromARGB(
                                              255, 230, 230, 230);
                                          btnHeight['c'] = 23;
                                          btnWidth['c'] = 23;
                                          btnTextColor['c'] = Colors.black;
                                          btnTextSize['c'] = 16;
                                          btnColor['d'] = const Color.fromARGB(
                                              255, 230, 230, 230);
                                          btnHeight['d'] = 23;
                                          btnWidth['d'] = 23;
                                          btnTextColor['d'] = Colors.black;
                                          btnTextSize['d'] = 16;
                                          nextPage();

                                          setState(() {
                                            isClicked = false;
                                          });
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                        child: Text(
                                          'Submit',
                                          style: whiteTextStyle.copyWith(
                                              fontSize: 18),
                                        ),
                                      ),
                                    )
                              : Container()
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

class PracticeResultScreen extends StatefulWidget {
  static const routeName = '/practiceQuestionsResult';
  var marks;
  var questionNumber;
  var skillID;
  PracticeResultScreen(this.marks, this.questionNumber, this.skillID,
      {Key? key})
      : super(key: key);

  @override
  _PracticeResultScreenState createState() =>
      _PracticeResultScreenState(marks, questionNumber, skillID);
}

class _PracticeResultScreenState extends State<PracticeResultScreen> {
  var marks;
  var questionNumber;
  var skillID;
  _PracticeResultScreenState(this.marks, this.questionNumber, this.skillID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        //  decoration: ThemeHelper.fullScreenBgBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            practiceQuestionsResultInfo(marks, questionNumber),
            bottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget bottomButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return PracticeQuestionScreen(widget.skillID);
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
          //     //     context, PracticeHistoryScreen.routeName);
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

  Widget practiceQuestionsResultInfo(var marks, int questionNumber) {
    return Column(
      children: [
        Image.asset(
          'images/practiceQuestionsResultBadge.png',
          //width: 130,
        ),
        Text(
          "Congratulations!",
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          "You have completed the practiceQuestions",
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
