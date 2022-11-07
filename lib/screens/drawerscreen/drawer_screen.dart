import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/controller/myController.dart';
import 'package:growup/screens/buildtestpapers.dart/showexamslist.dart';
import 'package:growup/screens/learninganalysisscreen/learninganalysispage.dart';
import 'package:growup/screens/loginscreens/loginsignuo.dart';
import 'package:growup/screens/profilescreen/profile_screen.dart';
import 'package:growup/screens/quizhistory/quizhistorylist.dart';
import 'package:growup/screens/studentcoursescreen/studentcourse.dart';
import 'package:growup/screens/tutorscreen/tutorlist.dart';
import 'package:growup/services/apiservice.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/apiserviceteacher.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isSwitched = false;
  final switchController = Get.put(MyController());
  var userId;
  var userDetails;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    userId = await getUserAppId();
    userDetails = getUserDetails(userId!);
    setState(() {});
    print("*-********************************************************");
    print(userId);
    print(userDetails);
  }

  @override
  Widget build(BuildContext context) {
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
    return Container(
      width: 300,
      color: darkBlueColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 40, bottom: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ));
                  },
                  child: CircleAvatar(
                    radius: 30,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                            //  BoxFit.cover,
                            "https://i.pinimg.com/originals/c8/f1/46/c8f14613fdfd69eaced69d0f1143d47d.jpg")),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                FutureBuilder<dynamic>(
                  future: userDetails,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //userFinalDetails!.fullName.toString()
                      var name = snapshot.data!.fullName.toString();
                      var email = snapshot.data!.userName.toString();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(.8),
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 30,
                            width: 180,
                            //color: Colors.red,
                            child: Text(
                              email,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        "No ratings",
                        style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      );
                    }
                    return const SizedBox(
                      height: 18,
                      width: 18,
                    );
                  },
                ),
              ],
            ),
            Column(
              children: <Widget>[
                const NewRow(
                  text: 'Settings',
                  icon: Iconsax.setting,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const LearningAnalysisPage();
                    },
                  )),
                  child: const NewRow(
                    text: 'Learning Analysis',
                    icon: Iconsax.receipt,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const QuizHistoryListScreen();
                    },
                  )),
                  child: const NewRow(
                    text: 'Quiz History',
                    icon: Iconsax.timer,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ExamsList();
                    },
                  )),
                  child: const NewRow(
                    text: 'Practice Questions',
                    icon: Iconsax.receipt,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TutorListScreen(),
                        ));
                  },
                  child: const NewRow(
                    text: 'Book Tutor',
                    icon: Iconsax.book_square,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                //CourseInfoScreen()
                                StudentCourseListScreen()));
                  },
                  child: const NewRow(
                    text: 'Enrollment',
                    icon: Iconsax.bookmark,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const NewRow(
                  text: 'Contact Us',
                  icon: Iconsax.call,
                ),
                const SizedBox(
                  height: 20,
                ),
                // const NewRow(
                //   text: 'Terms & Condition',
                //   icon: Iconsax.note,
                // ),
                const SizedBox(
                  height: 20,
                ),
                // Row(
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         Get.to(TeacherPage());
                //       },
                //       child: const Text(
                //         'App Mode',
                //         style: TextStyle(color: Colors.white, fontSize: 15),
                //       ),
                //     ),
                //     Obx(() {
                //       return Switch(
                //         value: switchController.isOn.value,
                //         onChanged: (value) {
                //           // setState(() {
                //           //   isSwitched = value;
                //           //   value = false;
                //           //   // print(isSwitched);
                //           // });
                //           switchController.isOn.toggle();
                //         },
                //         activeTrackColor: Colors.lightGreenAccent,
                //         activeColor: Colors.green,
                //       );
                //     }),
                //   ],
                // ),
              ],
            ),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () async {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.remove("tokenData");

                    final SharedPreferences sharedPreferences2 =
                        await SharedPreferences.getInstance();
                    sharedPreferences2.remove("userRole");
                    // Get.defaultDialog(
                    //     title: "Success!!",
                    //     middleText: "Logged Out",
                    //     actions: [
                    //       const Icon(
                    //         Iconsax.tick_circle,
                    //         size: 35,
                    //         color: Color.fromARGB(255, 23, 204, 92),
                    //       )
                    //     ],
                    //     buttonColor: Colors.white);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LoginSignupScreen();
                      },
                    ));
                    // Navigator.of(context, rootNavigator: true).push(
                    //   MaterialPageRoute<void>(
                    //     builder: (BuildContext context) => LoginSignupScreen(),
                    //   ),
                    // );
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Logged In'),
                    ));
                    // Navigator.pushAndRemoveUntil<void>(
                    //   context,
                    //   MaterialPageRoute<void>(
                    //     builder: (BuildContext context) => LoginSignupScreen(),
                    //   ),
                    //   (Route<dynamic> route) => false,
                    // );

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginSignupScreen(),
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Logged Out'),
                    ));
                    // Navigator.pushReplacementNamed(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     return LoginSignupScreen();
                    //   },
                    // ));
                    //Navigator.of(context, rootNavigator: true).pop(context);
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Log out',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData? icon;
  final String? text;

  const NewRow({
    Key? key,
    this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, color: const Color(0xfff85c0b)),
        const SizedBox(
          width: 20,
        ),
        Text(
          text!,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
