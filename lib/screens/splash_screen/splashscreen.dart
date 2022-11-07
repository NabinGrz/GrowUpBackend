import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/screens/loginscreens/loginsignuo.dart';
import 'package:growup/services/apiservice.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AnimationController _animationController;
  late Animation _animation;
  AnimationController? animationController;

  @override
  void initState() {
    //loadData();
    var token = getToken();
    print(
        "-------------------------------------------------------------------------------------");
    print(token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        //   mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: AnimatedSplashScreen(
              splash: Image.asset(
                "images/growupfinallogo.png",
                fit: BoxFit.contain,
                height: 150,
                width: 150,
              ),
              curve: Curves.easeInOut,
              duration: 2500,
              splashTransition: SplashTransition.scaleTransition,
              // pageTransitionType: PageTransitionType.,
              nextScreen: LoginSignupScreen(),
            ),
          ),

          const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Developed By Nabin Gurung",
                style: TextStyle(fontSize: 18, color: Color(0xFF8B8B8B)),
              )),
          //9806658041
        ],
      ),
    );
  }

  // Future<Timer> loadData() async {
  //   return Timer(Duration(milliseconds: 1100), onDoneLoading);
  // }

  // onDoneLoading() {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => LoginSignupScreen()));
  // }
}
