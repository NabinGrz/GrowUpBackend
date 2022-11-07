import 'package:flutter/material.dart';
import 'package:growup/colorpalettes/palette.dart';

class ErrorContent extends StatefulWidget {
  @override
  State<ErrorContent> createState() => _ErrorContentState();
}

class _ErrorContentState extends State<ErrorContent>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    final curvedAnimation = CurvedAnimation(
        parent: animationController!, curve: Curves.fastOutSlowIn);
    animation = Tween<double>(begin: 0, end: 1).animate(animationController!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController!.forward();
        }
      });

    animationController!.forward();
  }

  @override
  void dispose() {
    //to prevent app crash,exceptions,memory leak,running in background
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.width / 2),
                width: (MediaQuery.of(context).size.width / 2),
                // color: Colors.red,
                child: Opacity(
                  opacity: animation!.value,
                  child: Image.asset(
                    "images/wifi.png",

                    //   fit: BoxFit.contain,
                  ),
                )),
            SizedBox(
              height: 48,
            ),
            Text(
              'Ooops!',
              style: TextStyle(
                  color: Colors.red, fontSize: 30, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'No internet connection found!\nCheck you connection',
              style: TextStyle(
                  color: Colors.blueGrey,
                  // fontFamily: 'Raleway-Regular',
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 24,
            ),
            RaisedButton(
              color: Colors.blueGrey,
              onPressed: () {},
              child: Text(
                'Try again',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Raleway-Regular',
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
