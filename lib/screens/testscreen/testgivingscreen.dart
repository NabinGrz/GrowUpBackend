import 'package:flutter/material.dart';
import 'package:growup/models/testmodel.dart';
import 'package:growup/screens/homescreen/homepage_screen.dart';
import 'package:growup/services/testExamservices.dart';

import '../../colorpalettes/palette.dart';

class TestScreen extends StatefulWidget {
  var examID;
  TestScreen(this.examID, {Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState(examID);
}

class _TestScreenState extends State<TestScreen> {
  var examID;
  _TestScreenState(this.examID);
  @override
  var examTestLists;
  List<String>? k;
  Color answerBoxColors = Colors.white;
  Color correct = Colors.green;
  Color wrong = Colors.red;
  Color notselected = Colors.white;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    examTestLists = getAllTestofExam(widget.examID);
    setState(() {});
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
        body: Container(
          child: FutureBuilder<List<TestModel>>(
              future: examTestLists,
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data == null ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData ||
                    snapshot.data != null ||
                    snapshot.connectionState == ConnectionState.done) {
                  List<TestModel> listExamTest = snapshot.data;
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
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: whiteColor,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 212, 212, 212),
                                      blurRadius: 14,
                                      spreadRadius: 2,
                                      offset: Offset(3, 3)),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                listExamTest[index].question.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 24),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: whiteColor,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 212, 212, 212),
                                      blurRadius: 14,
                                      spreadRadius: 2,
                                      offset: Offset(3, 3)),
                                ]),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width - 35,
                              // color: Colors.red,
                              child: SingleChildScrollView(
                                physics: const ScrollPhysics(),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        listExamTest[index].options!.length,
                                    itemBuilder: (context, ansIndex) {
                                      k = ['a', 'b', 'c', 'd'];
                                      String selectedAns = listExamTest[index]
                                          .options![ansIndex]
                                          .isCorrectOption
                                          .toString();
                                      return Column(
                                        children: [
                                          choicebutton(
                                              k![ansIndex].toString(),
                                              listExamTest[index]
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
                          index == listExamTest.length - 1
                              ? ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              QuizResultScreen(
                                                  marks,
                                                  listExamTest.length,
                                                  widget.examID),
                                        ));
                                    // Get.to(QuizResultScreen(marks,
                                    //     listExamTest.length, widget.examID));
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
  var examID;
  QuizResultScreen(this.marks, this.questionNumber, this.examID, {Key? key})
      : super(key: key);

  @override
  _QuizResultScreenState createState() =>
      _QuizResultScreenState(marks, questionNumber, examID);
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  var marks;
  var questionNumber;
  var examID;
  _QuizResultScreenState(this.marks, this.questionNumber, this.examID);
  String message = "";
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
            bottomHomeButtons(),
          ],
        ),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePageScreen(),
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
              "Done",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget quizResultInfo(var marks, int questionNumber) {
    int obtainedMarks = int.parse(marks.toString().substring(0, 1));
    if (obtainedMarks <= 2) {
      message = "Very Poor!!";
      setState(() {});
    } else {
      message = "Congratulations!!";
      setState(() {});
    }
    return Column(
      children: [
        Image.asset(
          'images/quizResultBadge.png',
          //width: 130,
        ),
        Text(
          message,
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          "Your Score",
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          "$marks",
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}
