import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growup/adapters/practicerecord.dart';
import 'package:growup/adapters/quizhistory.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/courseadapter/studentcourse.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pie_chart/pie_chart.dart';

class LearningAnalysisPage extends StatefulWidget {
  const LearningAnalysisPage({Key? key}) : super(key: key);

  @override
  _LearningAnalysisPageState createState() => _LearningAnalysisPageState();
}

class _LearningAnalysisPageState extends State<LearningAnalysisPage> {
  final int _currentIndex = 0;
  bool isProgress = false;
  var enrolledCourseName;
  var enrolledCourseImage;
  Map<String, double>? dataMap = {
    "Food Items": 18.47,
    "Clothes": 17.70,
    "Technology": 4.25,
    "Cosmetics": 3.51,
    "Other": 2.83,
  };

  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539)
  ];

  final gradientList = <List<Color>>[
    [
      const Color(0xff0095fa),
      const Color(0xff645fef),
    ],
    [
      const Color.fromRGBO(129, 182, 205, 1),
      const Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      const Color.fromRGBO(175, 63, 62, 1.0),
      const Color.fromRGBO(254, 154, 92, 1),
    ],
    [
      const Color.fromRGBO(223, 250, 92, 1),
      const Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      const Color.fromARGB(255, 209, 10, 44),
      const Color.fromARGB(255, 207, 34, 100),
    ],
    [
      const Color.fromARGB(255, 204, 119, 8),
      const Color.fromARGB(255, 219, 128, 72),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFADC2F3),
                    Color(0xff6077F7),
                  ],
                ),
                color: Colors.purple[900],
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Stack(
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.022),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Get.off(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 100,
                      width: 150,
                      //color: Colors.red,
                      child: const Text(
                        "Learning Analysis",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      'images/learninganalysis.png',
                      width: 190,
                      //  color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: Container(
            //       height: 65,
            //       width: MediaQuery.of(context).size.width - (8 * edge),
            //       decoration: const BoxDecoration(),
            //       child: CustomNavigationBar(
            //         borderRadius: const Radius.circular(50),
            //         iconSize: 30.0,
            //         selectedColor: const Color(0xff040307),
            //         strokeColor: const Color(0x30040307),
            //         unSelectedColor: const Color(0xffacacac),
            //         backgroundColor: Colors.white,
            //         items: [
            //           CustomNavigationBarItem(
            //             icon: const Icon(Iconsax.graph),
            //             title: const Text("Progress"),
            //           ),
            //           CustomNavigationBarItem(
            //             icon: const Icon(Iconsax.speedometer),
            //             title: const Text("Performance"),
            //           ),
            //         ],
            //         currentIndex: _currentIndex,
            //         onTap: (index) {
            //           // setState(() {
            //           _currentIndex = index;
            //           if (_currentIndex == 0) {
            //             isProgress = true;
            //             setState(() {});
            //             print("Progress");
            //           } else if (_currentIndex == 1) {
            //             isProgress = false;
            //             setState(() {});
            //             print("Performance");
            //           }
            //           //  });
            //         },
            //       )),
            // ),

            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    "Enrolled Courses:",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                ),
                buildProgressCoursesWidgets(),
                const Divider(
                  thickness: 1,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 18),
                  child: Text(
                    "Overall Statistics:",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                ),
                buildPieChart(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildTestAttempted(),
                    //buildCorrretAnswer(),
                    buildAvergaeTimeSpend()
                  ],
                ),
                const SizedBox(
                  height: 50,
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: DottedBorder(
                      color: darkBlueColor,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10, 4],
                      strokeCap: StrokeCap.round,
                      child: Row(
                        children: [
                          Image.asset(
                            "images/thumsup.png",
                            height: 60,
                            width: 60,
                          ),
                          SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.5,
                            // color: Colors.red,
                            child: const Text(
                              """"The expert in anything was once a beginner.Keep Learning"
                                  """,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    )
                    // const
                    ),
                buildRecentPractice()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildProgressCoursesWidgets() {
    Box<StudentCourse> box = Hive.box<StudentCourse>('course');
    print("====================PRACTICE NUM==========================");
    print(box.length);

    return SizedBox(
      height: MediaQuery.of(context).size.height / 8,
      width: MediaQuery.of(context).size.width - 30,
      //color: Colors.amber,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: box.values.length,
        itemBuilder: (context, index) {
          if (box.values.isNotEmpty) {
            StudentCourse? obj = box.getAt(index);

            switch (int.parse(obj!.skillId)) {
              case 1:
                {
                  // setState(() {
                  enrolledCourseName = "Android Development Course";
                  enrolledCourseImage = "images/android.png";
                  //});
                }
                break;

              case 2:
                {
                  //setState(() {
                  enrolledCourseName = "Web Development Course";
                  enrolledCourseImage = "images/web.png";
                  //  });
                }
                break;

              case 3:
                {
                  //  setState(() {
                  enrolledCourseName = "Python Course";
                  enrolledCourseImage = "images/pythonc.png";
                  //  });
                }
                break;

              case 4:
                {
                  //  setState(() {
                  enrolledCourseName = "Adobe Illustrator Course";
                  enrolledCourseImage = "images/illustrator.png";
                  // });
                }
                break;
              case 5:
                {
                  // setState(() {
                  enrolledCourseName = "Adobe Photoshop Course";
                  enrolledCourseImage = "images/photoshopc.png";
                  // });
                }
                break;

              case 6:
                {
//setState(() {
                  enrolledCourseName = "3d Modelling Course";
                  enrolledCourseImage = "images/modelling.png";
                  // });
                }
                break;

              case 7:
                {
                  // setState(() {
                  enrolledCourseName = "Digital Marketing Course";
                  enrolledCourseImage = "images/marketing.png";
                  //});
                }
                break;

              case 8:
                {
                  // setState(() {
                  enrolledCourseName = "Social Media Marketing Course";
                  enrolledCourseImage = "images/marketing2.png";
                  // });
                }
                break;
              case 9:
                {
                  // setState(() {
                  enrolledCourseName = "Google Ads Course";
                  enrolledCourseImage = "images/ads.png";
                  // });
                }
                break;
              default:
                {
                  //setState(() {
                  enrolledCourseName = "Course";
                  enrolledCourseImage = "images/android.png";
                  // });
                }
                break;
            }
          } else {
            Container(
                color: Colors.red,
                width: 130,
                child: Text(
                  enrolledCourseName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                enrolledCourseImage,
                height: 50,
                width: 50,
              ),
              SizedBox(
                  width: 130,
                  child: Text(
                    enrolledCourseName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          );
        },
      ),
    );
  }

  Widget buildTestAttempted() {
    Box<PracticeRecord> box = Hive.box<PracticeRecord>('practice');

    //print(box.length);
    return SizedBox(
      height: MediaQuery.of(context).size.height / 8.5,
      // width: MediaQuery.of(context).size.width - 200,
      //color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "images/test.png",
            height: 50,
            width: 50,
          ),
          SizedBox(
              width: 130,
              child: Column(
                children: [
                  const Text(
                    "Practice Done",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    box.length.toString() == 0
                        ? "0/10"
                        : box.length.toString() + "/10",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget buildCorrretAnswer() {
    Box<PracticeRecord> quiz = Hive.box<PracticeRecord>('practice');
    print("====================QUIZ NUM==========================");
    //print(quiz);
    PracticeRecord? obj = quiz.getAt(1);
    String s = "34";
    print(obj!.score);
    return SizedBox(
      height: MediaQuery.of(context).size.height / 8.5,
      //   width: MediaQuery.of(context).size.width - 200,
      //color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "images/correct.png",
            height: 50,
            width: 50,
          ),
          SizedBox(
              width: 130,
              child: Column(
                children: [
                  const Text(
                    "Correct Answers",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    obj.score.substring(0, 2).replaceAll(".", ""),
                    //s.substring(0, 2),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget buildAvergaeTimeSpend() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 7.8,
      //   width: MediaQuery.of(context).size.width - 200,
      //color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "images/timespend.png",
            height: 50,
            width: 50,
          ),
          SizedBox(
              width: 130,
              child: Column(
                children: const [
                  Text(
                    "Avg.Time/ Questions",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "20min",
                    //s.substring(0, 2),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget buildRecentPractice() {
    Box<PracticeRecord> box = Hive.box<PracticeRecord>('practice');
    print("====================QUIZ NUM==========================");
    //print(quiz);
    //PracticeRecord? obj = box.getAt(1);
    String s = "34";
    //print(obj!.score);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Text(
            "Recently done practice's",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Text(
            "Continue practicing to improve your score",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
          ),
        ),
        // SizedBox(
        //   height: 180,
        //   width: 500,
        //   //color: Colors.amber,
        //   child: ListView.builder(
        //     itemCount: box.length,
        //     itemBuilder: (context, index) {
        //       PracticeRecord? obj = box.getAt(index);
        //       return Column(
        //         children: [
        //           box.isNotEmpty
        //               ? Row(
        //                   children: [
        //                     Padding(
        //                       padding: const EdgeInsets.only(left: 10.0),
        //                       child: Container(
        //                         width: 12,
        //                         height: 12,
        //                         decoration: BoxDecoration(
        //                           shape: BoxShape.circle,
        //                           // borderRadius: const BorderRadius.all(
        //                           //   Radius.circular(5),
        //                           // ),
        //                           gradient: LinearGradient(
        //                             colors: [
        //                               const Color(0xFF90A5F8),
        //                               darkBlueColor,
        //                             ],
        //                             begin: Alignment.topRight,
        //                             end: Alignment.bottomLeft,
        //                           ),
        //                           //  color: Colors.red[300]
        //                         ),
        //                       ),
        //                     ),
        //                     const SizedBox(
        //                       width: 20,
        //                     ),
        //                     Text(
        //                       obj!.dateTime.substring(5, 10),
        //                       style: const TextStyle(
        //                           fontSize: 20,
        //                           fontWeight: FontWeight.w300,
        //                           color: Colors.grey),
        //                     ),
        //                     const SizedBox(
        //                       width: 50,
        //                     ),
        //                     Expanded(
        //                       child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Text(
        //                             obj.quizname,
        //                             style: const TextStyle(
        //                                 fontSize: 18,
        //                                 fontWeight: FontWeight.w500),
        //                           ),
        //                           Text(
        //                             "Score:" + obj.score,
        //                             style: const TextStyle(
        //                                 fontSize: 16,
        //                                 fontWeight: FontWeight.w300,
        //                                 color: Colors.grey),
        //                           ),
        //                           const SizedBox(
        //                             height: 20,
        //                             child: Divider(
        //                               color: Color.fromARGB(255, 228, 228, 228),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 )
        //               : Container()
        //         ],
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }

  Widget buildPieChart() {
    Box<QuizHistory> quiz = Hive.box<QuizHistory>('history');
    late List name = [];
    List n = [];
    Map<String, double> quizMap = {};
    late List score = [];
    List s = [];

    for (int i = 0; i <= quiz.length - 1; i++) {
      QuizHistory? obj = quiz.getAt(i);
      n.add(obj!.quizname);
      name = n;
    }

    for (int i = 0; i <= quiz.length - 1; i++) {
      QuizHistory? obj = quiz.getAt(i);
      s.add(obj!.score);
      score = s;
    }

    for (int i = 0; i <= quiz.length - 1; i++) {
      //Map<String, double> quizMap = {
      quizMap[name[i]] = double.parse(score[i]);
      // };
    }
    print(name);
    print(quizMap);
    return Center(
        child: quizMap.isNotEmpty
            ? PieChart(
                dataMap: quizMap,
                colorList: colorList,
                chartRadius: MediaQuery.of(context).size.width / 2,
                centerText: "Quiz Overall",
                chartType: ChartType.disc,
                ringStrokeWidth: 35,
                centerTextStyle: TextStyle(
                    color: whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                //  ringStrokeWidth: 24,
                animationDuration: const Duration(seconds: 3),
                chartValuesOptions: const ChartValuesOptions(
                    showChartValues: true,
                    showChartValuesOutside: true,
                    decimalPlaces: 1,
                    //showChartValuesInPercentage: true,
                    chartValueStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                    showChartValueBackground: false),
                legendOptions: const LegendOptions(
                    showLegends: true,
                    legendShape: BoxShape.rectangle,
                    legendTextStyle: TextStyle(fontSize: 15),
                    legendPosition: LegendPosition.bottom,
                    showLegendsInRow: true),
                gradientList: gradientList,
              )
            : Container());
  }

  Widget buildPerformanceWidgets() {
    return Container(
      height: 100,
      width: 200,
      color: Colors.red,
    );
  }
}
