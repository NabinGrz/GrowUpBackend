// import 'package:flutter/material.dart';

// class OptionsCard extends StatelessWidget {
//   const OptionsCard({Key? key}) : super(key: key);
//   var listQuiz;
//   int quesIndex;
//   Widget option;
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: ScrollPhysics(),
//       child: ListView.builder(
//           shrinkWrap: true,
//           itemCount: listQuiz[index].options!.length,
//           itemBuilder: (context, ansIndex) {
//             List<String> k = ['a', 'b', 'c', 'd'];
//             String selectedAns =
//                 listQuiz[index].options![ansIndex].isCorrectOption.toString();
//             return Column(
//               children: [
//                 choicebutton(
//                     k[ansIndex].toString(),
//                     listQuiz[index].options![ansIndex].text.toString(),
//                     selectedAns),
//               ],
//             );
//           }),
//     );
//   }
// }
