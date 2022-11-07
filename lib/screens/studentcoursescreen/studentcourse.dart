import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/courseadapter/studentcourse.dart';
import 'package:growup/screens/coursescreen/courseinfo.dart';
import 'package:growup/screens/homescreen/homepage_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';

class StudentCourseListScreen extends StatefulWidget {
  @override
  State<StudentCourseListScreen> createState() =>
      _StudentCourseListScreenState();
}

class _StudentCourseListScreenState extends State<StudentCourseListScreen> {
  var skillID;
  Widget courseViewItem(StudentCourse course) {
    return Stack(
      children: [
        Container(
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
                    height: 130,
                    width: 150,
                    alignment: Alignment.bottomCenter,
                    // color: Colors.red,
                    child: Image.asset(
                      "images/mobileapplication.png",
                      fit: BoxFit.contain,
                    )
                    //  Image.network(
                    //   '$imageUrl',

                    // ),
                    ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.name.isEmpty ? "Course" : course.name,
                          style: const TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 300,
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        // Text(
                        //   course.noOfVideos,
                        //   style:
                        //       const TextStyle(fontSize: 16, color: Colors.grey),
                        // ),
                      ]),
                ),
              ],
            )),
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 55, 165, 79),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                  minimumSize: const Size(35, 35)),
              onPressed: () {
                Get.to(CourseInfo(
                    name: course.name,
                    imageUrl: course.imageUrl,
                    skillId: int.parse(course.skillId)));
              },
              child: const Icon(
                Iconsax.play,
                color: Colors.white,
              )),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Hive.box('course').clear();
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
                        Get.to(const HomePageScreen());
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
                    "Your Courses",
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
                      Hive.box<StudentCourse>('course').listenable(),
                  builder: (context, Box<StudentCourse> box, widget) {
                    if (box.values.isEmpty) {
                      return const Center(
                        child: Text("No course to show",
                            style: TextStyle(
                                color: Color.fromARGB(255, 96, 96, 96),
                                fontWeight: FontWeight.w400,
                                fontSize: 22)),
                      );
                    } else {}
                    //courseViewItem()

                    return ListView.builder(
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        StudentCourse? obj = box.getAt(index);
                        return GestureDetector(
                            onLongPress: () {
                              box
                                  .deleteAt(index)
                                  .then((value) => Fluttertoast.showToast(
                                        msg: "Your course has been deleted",
                                      ));
                            },
                            child: courseViewItem(obj!));
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
