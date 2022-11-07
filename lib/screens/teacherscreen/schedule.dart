import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/models/schedulemodel.dart';
import 'package:growup/services/apiserviceteacher.dart';
import 'package:growup/services/apiteacherschedule.dart';
import 'package:growup/services/testpaperbuild.dart';
import 'package:growup/widgets/shimmer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  String? _selectedTime;
  List<dynamic>? usersDetail;
  DateTime selectedDate = DateTime.now();
  bool successfull = false;
  var finalDate;
  var userId;
  bool isDeleted = false;
  @override
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
                primaryColor: Colors.black54,
                splashColor: Colors.black,
                brightness: Brightness.dark),
            child: child ?? const Text(""),
          );
        },
        initialTime: TimeOfDay.now());
    if (result != null) {
      int hour = result.hour;
      int minute = result.minute;
      String finalMinute = minute.toString();

      print("===================================================");
      print(hour);
      print(minute);
      if (finalMinute.length == 2) {
        print("fdzsssssssssdfsdfsd");
        setState(() {
          finalMinute = finalMinute;
        });
      } else {
        print("+++++++++++++++++++++++++");
        setState(() {
          finalMinute = "0" + finalMinute;
        });
      }
      print("final" + finalMinute);

      setState(() {
        _selectedTime = hour.toString() + ":" + finalMinute;
        print("Final Minute");
        print(_selectedTime);
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
                primaryColor: Colors.black54,
                splashColor: Colors.black,
                brightness: Brightness.dark),
            child: child ?? const Text(""),
          );
        });
    if (picked != null && picked != selectedDate) {
      String d = DateFormat("yyyy-MM-dd").format(picked);
      setState(() {
        selectedDate = DateTime.parse(d);
      });
      print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
      print(selectedDate);
    }
    finalDate = DateFormat("yyyy-MM-dd").format(selectedDate);
    return finalDate;
  }

  getData() async {
    userId = await getUserAppId();
    setState(() {});
    print("*-**********************USER ID**********************************");
    print(userId);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkBlueColor,
          title: const Text("Schedule"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Select your available time for classes",
                style: TextStyle(
                    fontSize: 22, color: Color.fromARGB(255, 101, 100, 100)),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Note: Your classes will be on Zoom App",
                style: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 101, 100, 100)),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width / 1.2,
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      _buildDateTime(context),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              successfull = true;
                            });
                            print(userId);
                            bool added = await postSchedule(
                                _selectedTime!, userId, finalDate.toString());
                            //Get.to(TestScreen(int.parse(examsList[index].id.toString())));
                            if (added) {
                              Fluttertoast.showToast(
                                  msg: "Successfully added schedule");
                              successfull = false;
                              setState(() {});
                              getAllScheduleofTeacher(userId ?? "0");
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Something went wrong");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 249, 106, 70),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                              minimumSize: const Size(150, 55)),
                          child: !successfull
                              ? const Text(
                                  "Add Schedule",
                                  style: TextStyle(fontSize: 20),
                                )
                              : const CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Scheduled",
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 101, 100, 100)),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width / 1.2,
                // decoration: BoxDecoration(
                //     borderRadius: const BorderRadius.all(Radius.circular(20)),
                //     color: whiteColor,
                //     boxShadow: const [
                //       BoxShadow(
                //           color: Colors.grey,
                //           blurRadius: 14,
                //           spreadRadius: 2,
                //           offset: Offset(3, 3)),
                //     ]),
                child: FutureBuilder<List<ScheduleModel>>(
                  future: getAllScheduleofTeacher(userId ?? "0"),
                  builder: (context, snapshot) {
                    var datas = snapshot.data;
                    if (snapshot.data == null ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return buildShimmerEffect(
                          context,
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width - 40,
                            color: const Color.fromARGB(255, 205, 205, 205),
                          ));
                    } else if (snapshot.hasData ||
                        snapshot.data != null ||
                        snapshot.connectionState == ConnectionState.done) {
                      return SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width - 40,
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: ListView.builder(
                              //scrollDirection: Axis.horizontal,
                              itemCount: datas!.length,
                              itemBuilder: (context, i) {
                                var sdate = datas[i].scheduleDateTime;
                                var tdate = DateTime.now();

                                final DateFormat formatter =
                                    DateFormat('yyyy-MM-dd');
                                final String sformatted =
                                    formatter.format(sdate!);
                                final String tformatted =
                                    formatter.format(tdate);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 0.0),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            height: 75,
                                            // width: 90,
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 223, 229, 228),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.calendar_month,
                                                  size: 35,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Time: " +
                                                          datas[i]
                                                              .time
                                                              .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      "Date: " +
                                                          datas[i]
                                                              .scheduleDateTime
                                                              .toString()
                                                              .substring(0, 10),
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                const Expanded(
                                                  child: SizedBox(
                                                    width: 10,
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      int id = datas[i].id!;
                                                      print("SCHEDULE ID: " +
                                                          id.toString());
                                                      //setState(() {});
                                                      bool del =
                                                          await deleteSchedule(
                                                              id);
                                                      if (del) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              'Deleted Sucessfully'),
                                                        ));
                                                        setState(() {});
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              'Something went wrong'),
                                                        ));
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      size: 35,
                                                      color: Colors.red,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 20,
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      child: const Divider(
                                        thickness: 2,
                                      ),
                                    )
                                  ],
                                );
                              }),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildDateTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Divider(
        //   thickness: 1,
        //   color: Color(0xFFD6D6D6),
        // ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 21,
          //color: Colors.yellow,
          child: const Text(
            'Schedule your Date',
            style: TextStyle(
                color: Color.fromARGB(255, 73, 73, 73),
                fontSize: 20.0,
                fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          height: 40.0,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: darkBlueColor,
            //border: Border.all(color: Colors.white)
          ),
          child: InkWell(
            onTap: () {
              _selectDate(context);
              print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ");
              // print(_selectDate(context).toString());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: darkBlueColor,
                      //border: Border.all(color: Colors.white)
                    ),
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(selectedDate),
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    )),
                Container(
                    child: const Icon(Iconsax.calendar_add,
                        color: Colors.white, size: 20))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 21,
          //color: Colors.yellow,
          child: const Text(
            'Schedule your Time',
            style: TextStyle(
                color: Color.fromARGB(255, 73, 73, 73),
                fontSize: 20.0,
                fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          height: 40.0,
          width: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: darkBlueColor,
            //border: Border.all(color: Colors.white)
          ),
          child: InkWell(
            onTap: () {
              _selectTime(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: darkBlueColor,
                      //border: Border.all(color: Colors.white)
                    ),
                    child: Text(
                      _selectedTime != null
                          ? _selectedTime!
                          : TimeOfDay.now().format(context),
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    )),
                Container(
                    child: const Icon(
                  Iconsax.watch,
                  color: Colors.white,
                  size: 20,
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
