import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/controller/tutorcontroller.dart';
import 'package:growup/screens/tutorscreen/searchtutor.dart';
import 'package:growup/screens/tutorscreen/tutordetailscreen.dart';
import 'package:growup/services/apiserviceteacher.dart';
import 'package:growup/widgets/shimmer.dart';

class TutorListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("BUIIIIIIIIIIIIIIIIIIIIIIIIIIIIILLLD");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchUser());
            },
            icon: const Icon(Icons.search_sharp),
          )
        ],
        centerTitle: true,
        title: GestureDetector(
          onTap: () {},
          child: const Text(
            'Available Tutors',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        StylistCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StylistCard extends StatefulWidget {
  // final stylist;
  // StylistCard(this.stylist);
  //const StylistCard({Key? key}) : super(key: key);
  @override
  State<StylistCard> createState() => _StylistCardState();
}

class _StylistCardState extends State<StylistCard> {
  final tutorController = Get.put(TutorController());
  // void initState() {
  //   super.initState();
  //   _dataTutor = tutorController.tutorList;
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: GetX<TutorController>(
      builder: (controller) {
        if (controller.isLoading == false) {
          return ListView.builder(
              itemCount: controller.tutorList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4 - 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xFF8A8A8A),
                            blurRadius: 14,
                            spreadRadius: 1,
                            offset: Offset(3, 3)),
                      ],
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff738AE6),
                          // darkBlueColor
                          Color(0xff5C5EDD),
                          // HexColor(#738AE6),
                          // HexColor(#5C5EDD),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      //  color: Colors.red[300]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 20,
                            right: -10,
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: -10,
                            //alignment: Alignment.bottomRight,
                            child: Image.asset(
                              "images/person.png",
                              fit: BoxFit.contain,
                              // height: 50,
                              // width: 50,
                              scale: 3,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${controller.tutorList[index].fullName}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${controller.tutorList[index].userName}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Color(0xFFFFF025),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    FutureBuilder<dynamic>(
                                      future: getAvergaeRatingCountTeacher(
                                          controller.tutorList[index].id),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          var average =
                                              snapshot.data!.toString();
                                          return Text(
                                            average,
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                        255, 255, 255, 255)
                                                    .withOpacity(.8),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                            "No ratings",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.8),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          );
                                        }
                                        return const SizedBox(
                                            height: 18,
                                            width: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ));
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    print(
                                        "00000000000000000000000000000000000000");
                                    print(controller.tutorList[index].id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TutorDetailScreen(
                                                    key: null,
                                                    usersDetail:
                                                        controller
                                                            .tutorList
                                                            .toList(),
                                                    tID: controller
                                                        .tutorList[index].id,
                                                    index: index)));
                                  },
                                  color: const Color(0xFFFF5252),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  // startColor: '#FE95B6',
                                  //endColor: '#FF5287',
                                  child: const Text(
                                    'View Profile',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else {
          return buildShimmerEffect(
            context,
            Column(
              children: [
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 4 - 32,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 15, 15),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        }
      },
    ));
  }
}
