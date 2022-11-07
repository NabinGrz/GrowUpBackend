import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/screens/drawerscreen/drawer_screen.dart';
import 'package:growup/screens/coursescreen/course_item.dart';
import 'package:growup/screens/homescreen/hometab_screen.dart';
import 'package:growup/screens/learnscreen/learnpage.dart';
import 'package:growup/screens/newsfeedscreen/newsfeed.dart';
import 'package:growup/screens/postscreen/postImage.dart';
import 'package:growup/screens/profilescreen/profile_screen.dart';

class LearnPageScreen extends StatefulWidget {
  const LearnPageScreen({Key? key}) : super(key: key);

  @override
  _LearnPageScreenState createState() => _LearnPageScreenState();
}

class _LearnPageScreenState extends State<LearnPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        // CourseItem(
        //     name: "Mobile Application Development",
        //     imageUrl: "images/mobileapplication.png")
        // CourseItem( "Mobile Application Development", "images/mobileapplication.png")
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
        //   child: courses(
        //       "Mobile Application Development", "images/mobileapplication.png"),
        // ),
        // Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
        //     child: courses("Graphic Designing", "images/graphicdesigning.png")),
        // Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
        //     child: courses("Web Development", "images/webapplication.png")),

        InkWell(
          onTap: () {},
          child: Container(
            // width: MediaQuery.of(context).size.width / 2,
            //  color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_box_outlined, color: Colors.blue),
                Text(
                  "Add Course",
                  style: TextStyle(
                      color: darkBlueColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
        // courses("Graphic Designing", "images/graphicdesigning.png"),
        // courses("Web Development", "images/webapplication.png")
      ],
    );
  }

  Widget courses(String name, String imageUrl) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.35,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 14,
                spreadRadius: 2,
                offset: Offset(3, 3)),
          ]),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.width * 0.34,
              width: MediaQuery.of(context).size.width * 0.34,
              //    color: Colors.red,
              child: Image.asset(
                '$imageUrl',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.53,
                //color: Colors.red,
                child: Text("$name",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.clip,
                    style: blackTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.055,
                    )),
              )),
        ],
      ),
    );
  }
}
