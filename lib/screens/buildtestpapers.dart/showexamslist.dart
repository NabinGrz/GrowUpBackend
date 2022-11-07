import 'package:flutter/material.dart';
import 'package:growup/models/exammodel.dart';
import 'package:growup/screens/testscreen/testgivingscreen.dart';
import 'package:growup/services/testExamservices.dart';

import '../../colorpalettes/palette.dart';

class ExamsList extends StatefulWidget {
  @override
  State<ExamsList> createState() => _ExamsListState();
}

class _ExamsListState extends State<ExamsList> {
  var skillID;

  @override
  var tests;
  getData() async {
    tests = await getAllExamList();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllExamList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkBlueColor,
          title: const Text("Available Exams"),
        ),
        //  backgroundColor: darkBlueColor,
        body: FutureBuilder<List<ExamModel>>(
            future: getAllExamList(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == null ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData ||
                  snapshot.data != null ||
                  snapshot.connectionState == ConnectionState.done) {
                List<ExamModel> examList = snapshot.data;

                return ListView.builder(
                    itemCount: examList.length,
                    itemBuilder: (context, index) {
                      return quizHistoryViewItem(examList, index, context);
                    });
              }
              return Container(
                color: Colors.yellow,
              );
            }),
      ),
    );
  }
}

Widget quizHistoryViewItem(var examsList, int index, BuildContext context) {
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                examsList[index].name!,
                style: const TextStyle(fontSize: 24),
              ),
              Text("Difficulty Level: ${examsList[index].difficulty}",
                  style:
                      const TextStyle(color: Colors.redAccent, fontSize: 18)),
              Text(
                "Created By: ${examsList[index].tutorName}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Total No.Of Questions: ${examsList[index].totalQuestions}",
                style: const TextStyle(fontSize: 18),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestScreen(
                            int.parse(examsList[index].id.toString())),
                      ));
                  // Get.to(TestScreen(int.parse(examsList[index].id.toString())));
                },
                style: ElevatedButton.styleFrom(
                    primary: darkBlueColor,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    minimumSize: const Size(120, 45)),
                child: const Text("Start Test")),
          ),
        ],
      ));
}
