import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/models/skillsdetailmodel.dart';
import 'package:growup/screens/buildtestpapers.dart/BuildTestPaperScree.dart';
import 'package:growup/services/apiservice.dart';
import 'package:growup/services/testExamservices.dart';

class BuildExamScreen extends StatefulWidget {
  const BuildExamScreen({Key? key}) : super(key: key);

  @override
  State<BuildExamScreen> createState() => _BuildExamScreenState();
}

class _BuildExamScreenState extends State<BuildExamScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController tutorNameController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController option3 = TextEditingController();
  TextEditingController option4 = TextEditingController();

  bool added = false;
  bool isTest = false;
  var skillID;
  var _currentItemSelected = 'The Complete Mobile Application Development';
  var _currentDiff = 'Easy';
  bool valuefirst = false;
  bool valuesecond = false;
  var selectedIndex;
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
            title: const Text("Build Exams"),
          ),
          backgroundColor: const Color.fromARGB(255, 216, 222, 255),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                buildTitle(
                    10, 2, 27, "Generate Exams", FontWeight.w400, Colors.black),
                const SizedBox(
                  height: 5,
                ),
                buildTitle(
                    10,
                    10,
                    18,
                    "Generate exams for students to test their knowledge and boost up their skills",
                    FontWeight.w300,
                    const Color.fromARGB(255, 86, 86, 86)),
                const SizedBox(
                  height: 14,
                ),
                buildTitle(
                    10, 2, 18, "Select Skills*", FontWeight.w500, Colors.black),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        color: whiteColor,
                        border: Border.all(
                            color: const Color.fromARGB(255, 119, 118, 118))),
                    child: FutureBuilder<List<SkillsDetailModel>>(
                      future: _skillsDetail,
                      builder: (context, snapshot) {
                        if (snapshot.data == null ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(9)),
                                color: whiteColor,
                                border: Border.all(color: Colors.blueGrey)),
                            child: const Center(),
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
                            child: DropdownButton<String>(
                              elevation: 20,
                              value: _currentItemSelected,
                              items: nameList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
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
                                  selectedIndex = nameList
                                      .indexOf(_currentItemSelected)
                                      .toString();
                                  skillID = snapshot
                                      .data![int.parse(selectedIndex)].id!
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
                ),
                const SizedBox(
                  height: 20,
                ),
                buildTitle(
                    10, 2, 18, "Exam Title*", FontWeight.w500, Colors.black),
                buildTextField(null, "Test Name", false, false, nameController,
                    TextInputType.name),
                const SizedBox(
                  height: 14,
                ),
                buildTitle(
                    10, 2, 18, "Difficulty*", FontWeight.w500, Colors.black),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: whiteColor,
                        border: Border.all(color: Colors.blueGrey)),
                    child: DropdownButton<String>(
                      // Step 3.
                      value: _currentDiff,
                      // Step 4.
                      items: <String>['Easy', 'Medium', 'Hard']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
                        _currentDiff = newValue!;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                buildTitle(
                    10, 2, 18, "Your Name*", FontWeight.w500, Colors.black),
                const SizedBox(
                  height: 14,
                ),
                buildTextField(null, "Tutor Name", false, false,
                    tutorNameController, TextInputType.name),
                buildTitle(10, 2, 18, "No.of Question*", FontWeight.w500,
                    Colors.black),
                const SizedBox(
                  height: 14,
                ),
                buildTextField(null, "Total No.of Questions", false, false,
                    questionController, TextInputType.name),
                const SizedBox(
                  height: 30,
                ),
                buildTitle(
                    10,
                    2,
                    13,
                    "Note: Create exam before creating questions",
                    FontWeight.w500,
                    const Color.fromARGB(255, 147, 147, 147)),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 160,
                        height: 45,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xffFE876C), Color(0xffFD5D37)]),
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                        child: FlatButton(
                            onPressed: () async {
                              isTest
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const BuildTestPaper(),
                                      ))
                                  : Fluttertoast.showToast(
                                      msg: "Please create an exam first",
                                    );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Text(
                              "Add Questions",
                              style: whiteTextStyle.copyWith(fontSize: 18),
                            )),
                      ),
                      buildButton(const Color(0xffFE876C),
                          const Color(0xffFD5D37), "Add Exam"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
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
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: blackColor),
            //   borderRadius: const BorderRadius.all(Radius.circular(35.0)),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: darkBlueColor),
            //   borderRadius: const BorderRadius.all(Radius.circular(35.0)),
            // ),
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  Widget buildButton(Color color1, Color color2, String buttonText) {
    return Container(
      width: 140,
      height: 45,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            // Color(0xffFE876C),
            color1,
            color2
            //  Color(0xffFD5D37),
          ],
        ),
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      child: FlatButton(
          onPressed: () async {
            added = true;
            setState(() {});
            added = await postExam(
                skillID.toString(),
                nameController.text,
                _currentDiff,
                tutorNameController.text,
                questionController.text);
            setState(() {});
            if (added) {
              Fluttertoast.showToast(
                msg: "Exam has been created successfully",
              );
              added = false;
              isTest = true;
              setState(() {});
            } else {
              Fluttertoast.showToast(
                msg: "Exam cannot be added.SORRY!!",
              );
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
          child: added
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  "Create Exam",
                  style: whiteTextStyle.copyWith(fontSize: 18),
                )),
    );
  }

  Widget buildTitle(double h, double w, double fsize, String name,
      FontWeight weight, Color c) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: w),
      child: Text(
        name,
        style: TextStyle(fontSize: fsize, fontWeight: weight, color: c),
      ),
    );
  }
}
