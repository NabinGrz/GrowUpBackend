import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/models/skillsdetailmodel.dart';
import 'package:growup/services/apiservice.dart';
import 'package:growup/services/testpaperbuild.dart';

class BuildQuizScreen extends StatefulWidget {
  const BuildQuizScreen({Key? key}) : super(key: key);

  @override
  State<BuildQuizScreen> createState() => _BuildQuizScreenState();
}

class _BuildQuizScreenState extends State<BuildQuizScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController option1 = TextEditingController();
  TextEditingController option2 = TextEditingController();
  TextEditingController option3 = TextEditingController();
  TextEditingController option4 = TextEditingController();
  bool isAdded = false;
  bool checkedValue1 = false;
  bool checkedValue2 = false;
  bool checkedValue3 = false;
  bool checkedValue4 = false;
  var questionIndex;
  final skills = [
    'The Complete Mobile Application Development',
    'Web Development Masterclass',
    'Ultimate Python Course',
    'Illustrator 2022 Masterclass',
    'Ultimate Adobe Photoshop',
    'Learn 3d Modelling',
    'Complete Digital Marketing Course',
    'Social Media Marketing 2022',
    'Ultimate Google Ads Training'
  ];
  bool added = false;
  bool isTest = false;
  var skillID;
  var selectedIndex;
  var _currentItemSelected = 'Illustrator 2022 Masterclass';
  final _currentDiff = 'Easy';
  bool valuefirst = false;
  bool valuesecond = false;
  Future<List<SkillsDetailModel>>? _skillsDetail;
  @override
  void initState() {
    super.initState();
    _skillsDetail = getSkillDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: darkBlueColor,
            title: const Text("Build Test"),
          ),
          backgroundColor: const Color.fromARGB(255, 216, 222, 255),
          body: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [buildQuestion(), buildOptions()],
            ),
          )),
    );
  }

  Widget buildTextField(IconData? icon, String hintText, bool isPassword,
      bool isEmail, TextEditingController controller, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
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
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  // Widget buildButton(Color color1, Color color2, String buttonText) {
  //   return Container(
  //     width: 120,
  //     height: 50,
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: Alignment.topCenter,
  //         end: Alignment.bottomCenter,
  //         colors: [
  //           // Color(0xffFE876C),
  //           color1,
  //           color2
  //           //  Color(0xffFD5D37),
  //         ],
  //       ),
  //       borderRadius: BorderRadius.circular(
  //         10.0,
  //       ),
  //     ),
  //     child: FlatButton(
  //         onPressed: () async {
  //           added = true;
  //           setState(() {});
  //           added = await postExam(
  //               skillID.toString(),
  //               nameController.text,
  //               _currentDiff,
  //               tutorNameController.text,
  //               questionController.text);
  //           setState(() {});
  //           if (added) {
  //             Fluttertoast.showToast(
  //               msg: "Exam has been created successfully",
  //             );
  //             added = false;
  //             isTest = true;
  //             setState(() {});
  //           } else {
  //             Fluttertoast.showToast(
  //               msg: "Exam cannot be added.SORRY!!",
  //             );
  //           }
  //         },
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(17),
  //         ),
  //         child: added
  //             ? const CircularProgressIndicator(
  //                 color: Colors.white,
  //               )
  //             : Text(
  //                 buttonText,
  //                 style: whiteTextStyle.copyWith(fontSize: 18),
  //               )),
  //   );
  // }

  Widget buildQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        buildTitle(10, 2, 27, "Build Quiz", FontWeight.w600, Colors.black),
        const SizedBox(
          height: 5,
        ),
        buildTitle(
            10,
            10,
            18,
            "Build quiz for students to test their knowledge and boost up their skills",
            FontWeight.w300,
            const Color.fromARGB(255, 86, 86, 86)),
        const SizedBox(
          height: 20,
        ),
        buildTitle(10, 2, 18, "Select Skills*", FontWeight.w500, Colors.black),
        const SizedBox(
          height: 14,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: FutureBuilder<List<SkillsDetailModel>>(
            future: _skillsDetail,
            builder: (context, snapshot) {
              if (snapshot.data == null ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(9)),
                      color: whiteColor,
                      border: Border.all(color: Colors.blueGrey)),
                  child: Center(
                      child: CircularProgressIndicator(color: darkBlueColor)),
                );
              } else if (snapshot.hasData ||
                  snapshot.data != null ||
                  snapshot.connectionState == ConnectionState.done) {
                var skillsData = snapshot.data!;

                List<String> skillNameList = [];
                int i = 0;
                late List<String> nameList;
                for (i = 0; i <= (skillsData.length - 1); i++) {
                  skillNameList.add(skillsData[i].title!);
                  nameList = skillNameList;
                }
                return Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      color: whiteColor,
                      border: Border.all(
                          color: const Color.fromARGB(255, 119, 118, 118))),
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
                                color: Colors.blueGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (String? newValue) {
                      setState(() {
                        _currentItemSelected = newValue!;
                        selectedIndex =
                            nameList.indexOf(_currentItemSelected).toString();
                        skillID = snapshot.data![int.parse(selectedIndex)].id!
                            .toString();
                      });

                      print("SELECTED INDEX:" + selectedIndex);
                      print("SELECTED SKILL ID:" + skillID);
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        buildTitle(10, 2, 18, "Quiz question*", FontWeight.w500, Colors.black),
        const SizedBox(
          height: 14,
        ),
        buildTextField(null, "Write your question here", false, false,
            questionController, TextInputType.name),
        const SizedBox(
          height: 20,
        ),
      ],
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

  Widget buildOptions() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(10, 2, 18, "Quiz options*", FontWeight.w500, Colors.black),
          const SizedBox(
            height: 14,
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
              width: 180,
              height: 50,
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
                  isAdded = true;
                  setState(() {});
                  var quizPosted =
                      await postQuiz(skillID, questionController.text);
                  var data = await getQuiz(int.parse(skillID));
                  var l = data.length;
                  var finalIndex = l - 1;
                  if (finalIndex < 0) {
                    questionIndex = data[0].id;
                    setState(() {});
                  } else {
                    questionIndex = data[finalIndex].id;
                    setState(() {});
                  }

                  print("************INDEX OF QUESTION********************");
                  print(questionIndex);

                  if (quizPosted) {
                    var data = await getQuiz(int.parse(skillID));
                    var l = data.length;
                    var finalIndex = l - 1;
                    print("************AFTER QUIZ LENGTH********************");
                    print(l);
                    print(finalIndex);

                    await postQuizOptions(
                        option1.text, questionIndex.toString(), checkedValue1);
                    await postQuizOptions(
                        option2.text, questionIndex.toString(), checkedValue2);
                    await postQuizOptions(
                        option3.text, questionIndex.toString(), checkedValue3);
                    isAdded = await postQuizOptions(
                        option4.text, questionIndex.toString(), checkedValue4);

                    if (isAdded) {
                      option1.text = "";
                      option2.text = "";
                      option3.text = "";
                      option4.text = "";
                      questionController.text = "";
                      Fluttertoast.showToast(
                        msg: "Quiz has been added successfully",
                      );
                      isAdded = false;
                      setState(() {});
                      print("LENGTH IS:" + l.toString());
                    } else {
                      Fluttertoast.showToast(
                        msg: "Quiz cannot be added.SORRY!!",
                      );
                    }
                  } else {
                    isAdded = false;
                    setState(() {});
                    Fluttertoast.showToast(
                      msg: "Something went wrong",
                    );
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                child: !isAdded
                    ? Text(
                        'Add Quiz',
                        style: whiteTextStyle.copyWith(fontSize: 18),
                      )
                    : const CircularProgressIndicator(
                        color: Colors.white,
                      ),
              )),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
