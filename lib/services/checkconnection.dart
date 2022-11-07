import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:growup/nointernet.dart';
import 'package:growup/screens/loginscreens/loginsignuo.dart';

class CheckConnection extends StatelessWidget {
  const CheckConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Internet Connectivity',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Internet Connectivity'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String status = "Waiting...";
  Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkConnectivity();
    checkRealtimeConnection();
  }

  void checkConnectivity() async {
    var connectionResult = await _connectivity.checkConnectivity();

    if (connectionResult == ConnectivityResult.mobile) {
      status = "MobileData";
      print("Modile Data Connection");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginSignupScreen()));
    } else if (connectionResult == ConnectivityResult.wifi) {
      status = "Wifi";
      print("Wifi Connection");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginSignupScreen()));
    } else {
      status = "Not Connected";
      print("nooooooooooooooooooo Connection");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CheckConnection()));
    }
    setState(() {});
  }

  void checkRealtimeConnection() {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile) {
        status = "MobileData";
        print("Modile Data Connection");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoginSignupScreen()));
      } else if (event == ConnectivityResult.wifi) {
        status = "Wifi";
        print("Wifi Connection");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoginSignupScreen()));
      } else {
        status = "Not Connected";
        print("nooooooooooooo Connection");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CheckConnection()));
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ErrorContent();
  }
}
