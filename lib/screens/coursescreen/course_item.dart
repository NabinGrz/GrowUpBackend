import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/screens/coursescreen/courseinfo.dart';
import 'package:growup/screens/studentcoursescreen/studentcourse.dart';
import 'package:growup/widgets/shimmer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../courseadapter/studentcourse.dart';

class CourseItem extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  Future<int> noOfVideos;
  final int? skillId;
  var skill;

  CourseItem(
      {required this.name,
      required this.imageUrl,
      required this.noOfVideos,
      required this.skill,
      required this.skillId});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(
            "=====================================================================");
        print("YESSSSSSSSSSSS");
        // if(skill == "Development")
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CourseInfo(
                    name: name, imageUrl: imageUrl, skillId: skillId)));
      },
      child: Container(
        height: MediaQuery.of(context).size.width * 0.6,
        width: MediaQuery.of(context).size.width * 0.4,
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
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    //CourseInfoScreen()
                                    StudentCourseListScreen()));
                        Box<StudentCourse> box =
                            Hive.box<StudentCourse>('course');
                        box.add(StudentCourse(name!, imageUrl!,
                            noOfVideos.toString(), skillId.toString()));
                        Fluttertoast.showToast(
                          msg: "Your course has been added",
                        );
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF90A5F8),
                              darkBlueColor,
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          //  color: Colors.red[300]
                        ),
                        child: const Icon(
                          Iconsax.add,
                          color: Colors.white,
                        ),
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.35,
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    // color: Colors.red,
                    child: Image.network(
                      '$imageUrl',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
              //color: Colors.green,
              child: Align(
                alignment: Alignment.center,
                child: Text("$name",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: blackTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                    )),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            FutureBuilder<int>(
                future: noOfVideos,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.data == null ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: buildShimmerEffect(
                        context,
                        Container(
                          height: 20,
                          width: 90,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasData ||
                      snapshot.data != null ||
                      snapshot.connectionState == ConnectionState.done) {
                    String c = snapshot.data.toString();
                    return Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(c + " Videos",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400)));
                  }
                  return Container(
                    color: Colors.yellow,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
