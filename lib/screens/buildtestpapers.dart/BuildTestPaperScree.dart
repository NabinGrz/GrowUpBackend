import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/models/exammodel.dart';
import 'package:growup/services/testExamservices.dart';

class BuildTestPaper extends StatefulWidget {
  const BuildTestPaper({Key? key}) : super(key: key);

  @override
  State<BuildTestPaper> createState() => _BuildTestPaperState();
}

class _BuildTestPaperState extends State<BuildTestPaper> {
  TextEditingController testController = TextEditingController();
  TextEditingController option1 = TextEditingController();
  TextEditingController option2 = TextEditingController();
  TextEditingController option3 = TextEditingController();
  TextEditingController option4 = TextEditingController();
  var questions;
  List<ExamModel>? examList;
  var skillID = [];
  var selectedIndex;
  var examID;
  var _currentItemSelected;
  bool options = false;
  bool checkedValue1 = false;
  bool checkedValue2 = false;
  bool checkedValue3 = false;
  bool checkedValue4 = false;
  Future getAllData() async {
    // do the api stuff
    examList = await getAllExamList();
    _currentItemSelected = examList![0].name;
    setState(() {});
    return examList![0].name;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllExamList();

    options = true;
    setState(() {});
    //  getExam();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 216, 222, 255),
          appBar: AppBar(
            backgroundColor: darkBlueColor,
            title: const Text("GrowUp"),
          ),
          body: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [buildQuestion(), buildOptions()],
            ),
          )),
    );
  }

  Widget buildTitle(double h, double w, double fsize, String name,
      FontWeight weight, Color c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        name,
        style: TextStyle(fontSize: fsize, fontWeight: weight, color: c),
      ),
    );
  }

  Widget buildTextField(IconData? icon, String hintText, bool isPassword,
      bool isEmail, TextEditingController controller, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 198, 198, 198),
                  blurRadius: 14,
                  spreadRadius: 2,
                  offset: Offset(3, 3)),
            ]),
        child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: type,
          decoration: InputDecoration(
            // labelText: "NabinGurung",
            errorText: null,
            prefixIcon: Icon(
              icon,
              color: iconColor,
            ),
            //contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  Widget buildQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        buildTitle(10, 2, 18, "Select Exam*", FontWeight.w500, Colors.black),
        const SizedBox(
          height: 14,
        ),
        FutureBuilder<List<ExamModel>>(
          future: getAllExamList(),
          builder: (context, snapshot) {
            if (snapshot.data == null ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 55,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(9)),
                    color: whiteColor,
                    border: Border.all(color: Colors.blueGrey)),
                child: const Center(),
              );
            } else if (snapshot.hasData ||
                snapshot.data != null ||
                snapshot.connectionState == ConnectionState.done) {
              List<String> examNameList = [];
              int i = 0;
              late List<String> nameList;
              for (i = 0; i <= (snapshot.data!.length - 1); i++) {
                examNameList.add(snapshot.data![i].name!);
                nameList = examNameList;
              }
              print("*****************************************");
              print(snapshot.data![0].name!);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: whiteColor,
                      border: Border.all(color: Colors.blueGrey)),
                  child: DropdownButton<String>(
                    // Step 3.
                    /// value: snapshot.data![0].name!,
                    value: _currentItemSelected,
                    // Step 4.
                    items:
                        nameList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (String? newValue) {
                      _currentItemSelected = newValue!;
                      setState(() {
                        selectedIndex =
                            nameList.indexOf(_currentItemSelected).toString();
                        examID = snapshot.data![int.parse(selectedIndex)].id!
                            .toString();
                      });
                      print("SELECTED:" + _currentItemSelected);
                      print("SELECTED:" + selectedIndex);
                      print("EXAM ID:" + examID.toString());
                    },
                  ),
                ),
              );
            }
            return Container();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        buildTitle(10, 2, 18, "Exam question*", FontWeight.w500, Colors.black),
        const SizedBox(
          height: 10,
        ),
        buildTextField(null, "Write your question here", false, false,
            testController, TextInputType.name),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget buildOptions() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          buildTitle(10, 2, 18, "Exam options*", FontWeight.w500, Colors.black),
          const SizedBox(
            height: 10,
          ),
          buildTextField(
              null, "Option1", false, false, option1, TextInputType.name),
          SizedBox(
            height: 50,
            //color: Colors.yellow,
            child: CheckboxListTile(
              title: const Text("Is Correct Answer"),
              value: checkedValue1,
              onChanged: (newValue) {
                setState(() {
                  checkedValue1 = newValue!;
                });
                print("*********************************************");
                print(checkedValue1);
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
          ),
          buildTextField(
              null, "Option1", false, false, option2, TextInputType.name),
          SizedBox(
            height: 50,
            //color: Colors.yellow,
            child: CheckboxListTile(
              title: const Text("Is Correct Answer"),
              value: checkedValue2,
              onChanged: (newValue) {
                setState(() {
                  checkedValue2 = newValue!;
                  print("*********************************************");
                  print(checkedValue2);
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
          ),
          buildTextField(
              null, "Option1", false, false, option3, TextInputType.name),
          SizedBox(
            height: 50,
            //color: Colors.yellow,
            child: CheckboxListTile(
              title: const Text("Is Correct Answer"),
              value: checkedValue3,
              onChanged: (newValue) {
                setState(() {
                  checkedValue3 = newValue!;
                  print("*********************************************");
                  print(checkedValue3);
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
          ),
          buildTextField(
              null, "Option1", false, false, option4, TextInputType.name),
          SizedBox(
            height: 50,
            //color: Colors.yellow,
            child: CheckboxListTile(
              title: const Text("Is Correct Answer"),
              value: checkedValue4,
              onChanged: (newValue) {
                setState(() {
                  checkedValue4 = newValue!;
                  print("*********************************************");
                  print(checkedValue4);
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
          ),
          Container(
            width: 170,
            height: 45,
            margin: const EdgeInsets.symmetric(horizontal: 120),
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
                10.0,
              ),
            ),
            child: FlatButton(
                onPressed: () async {
                  options = false;
                  setState(() {});
                  var data = await getAllTestofExam(int.parse(examID));
                  var l = data.length;
                  print("************LENGTH********************");
                  print(l);

                  // var l = await questions.length;
                  // var finalIndex = l - 1;

                  bool posted = await postTest(testController.text, examID);

                  if (posted) {
                    var d = await getAllTestofExam(int.parse(examID));
                    var l = d.length;
                    print("************LENGTH********************");
                    print(l);
                    var finalIndex = l - 1;
                    var testIndex = d[finalIndex].id;
                    print("**************TEST INDEX*******************");

                    print(testIndex);
                    // print("************2LENGTH********************");
                    // print(l);
                    await postTestOptions(
                        option1.text, testIndex.toString(), checkedValue1);
                    await postTestOptions(
                        option2.text, testIndex.toString(), checkedValue2);
                    await postTestOptions(
                        option3.text, testIndex.toString(), checkedValue3);
                    options = await postTestOptions(
                        option4.text, testIndex.toString(), checkedValue4);
                    setState(() {});
                    options
                        ? Fluttertoast.showToast(
                            msg: "Question has been added successfully",
                          )
                        : Fluttertoast.showToast(
                            msg: "Question cannot be added.SORRY!!",
                          );
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                child: options
                    ? Text(
                        'Add Questions',
                        style: whiteTextStyle.copyWith(fontSize: 18),
                      )
                    : const CircularProgressIndicator(
                        color: Colors.white,
                      )),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
