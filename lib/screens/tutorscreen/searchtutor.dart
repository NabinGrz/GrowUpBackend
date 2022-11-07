import 'package:flutter/material.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/models/teachermodel.dart';
import 'package:growup/models/users_model.dart';
import 'package:growup/screens/tutorscreen/tutordetailscreen.dart';
import 'package:growup/services/apiservice.dart';

class SearchUser extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(
    BuildContext context,
  ) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(
    BuildContext context,
  ) {
    return FutureBuilder<List<dynamic>>(
        future: getTeacherDetails(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<dynamic>? data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: darkBlueColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Image.asset("images/person.png")),
                      ),
                      SizedBox(width: 20),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data?[index].fullName}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${data?[index].email}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ])
                    ],
                  ),
                );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container(
        color: Colors.black,
        child: FutureBuilder<List<TeacherModel>>(
          future: getTeacherDetails(query: query),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoSuggestions();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Expanded(
                    child: Container(
                        color: darkBlueColor,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.red,
                        ))));
              default:
                if (snapshot.hasError || snapshot.data!.isEmpty) {
                  return buildNoSuggestions();
                } else {
                  return Column(
                    children: [
                      //  Text(snapshot.data.length),
                      buildSuggestionsSuccess(snapshot.data!),
                    ],
                  );
                }
            }
          },
        ),
      );

  Widget buildNoSuggestions() => Center(
      child: Expanded(
          child: Container(
              color: darkBlueColor,
              child: Center(
                child: Text(
                  'No tutors found!',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ))));

  Widget buildSuggestionsSuccess(List<TeacherModel> suggestions) => Expanded(
        child: Container(
          color: darkBlueColor,
          // ignore: avoid_unnecessary_containers
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // String foundCourse =
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Found " + suggestions.length.toString() + " Tutors",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Container(
                  //  color: darkBlueColor,
                  height: 450,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      print("The index are");
                      print(suggestions.length);
                      final suggestion = suggestions[index];
                      final queryText = suggestion.fullName
                          .toString()
                          .substring(0, query.length);
                      final remainingText = suggestion.fullName
                          .toString()
                          .substring(query.length);

                      return Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: ListTile(
                          onTap: () {
                            // query = suggestion.name.toString();
                            print(
                                "===========================================");
                            print("$index");
                            // 1. Show Results
                            showResults(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TutorDetailScreen(
                                        key: null,
                                        usersDetail: suggestions.toList(),
                                        index: index)));
                            // 2. Close Search & Return Result
                            // close(context, suggestion);

                            // 3. Navigate to Result Page
                            //  Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) => ResultPage(suggestion),
                            //   ),
                            // );
                          },
                          // leading: Icon(Icons.location_city),
                          // title: Text(suggestion),
                          title: RichText(
                            text: TextSpan(
                              text: queryText,
                              style: TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: remainingText,
                                  style: TextStyle(
                                    color: Color(0xFFB4B4B4),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
/*return buildShimmerEffect(
                      context,
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 4 - 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    );
*/