import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/controller/myController.dart';
import 'package:growup/screens/forgetpassword/forgetpasswordscreen.dart';
import 'package:growup/screens/homescreen/homepage_screen.dart';
import 'package:growup/screens/teacherscreen/teacherpage.dart';
import 'package:growup/services/apiservice.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginSignupScreen extends StatefulWidget {
  //static var tokenData;
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  var tokenData;
  var userRole;
  bool isSignupScreen = true;
  bool isMale = true;
  bool isLogging = false;
  String? gender = "Male";
  //static var tokenData;
  bool isRememberMe = false;
  final _currencies = ['Student', 'Teacher'];
  var _currentItemSelected = 'Student';
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var textValue;
  bool isValid = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullnameSignup = TextEditingController();
  TextEditingController emailSignup = TextEditingController();
  TextEditingController passwordSignup = TextEditingController();
  final genderController = Get.put(MyController());
  bool emailError = false;
  bool passwordError = false;
  bool fullnameSignupError = false;
  bool emailSignupError = false;
  bool passwordSignupError = false;
  final tokenDataStorage = const FlutterSecureStorage();
  final userIdDataStorage = const FlutterSecureStorage();
  static String? finaltokenData;
  Timer? _timer;

  checkValue() async {
    String value1 = await getData() ?? "";
    String value2 = await getRole() ?? "";
    if (await getData() == null && await getRole() == null) {
      print("IS NULL");
    } else {
      print("Token Available");
      print(value1);
      print("Role Avialable");
      print(value2);
      await Future.delayed(
          const Duration(seconds: 0),
          () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                if (value2 == "Student") {
                  return const HomePageScreen();
                } else if (value2 == "Teacher") {
                  return TeacherPage();
                } else {}
                return TeacherPage();
              })));
    }
  }

  Future getData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedtokenData = sharedPreferences.getString("tokenData");
    // print("THE TOKEN OF THIS USER IS SAVED");
    // print(obtainedtokenData);
    return obtainedtokenData;
  }

  Future getRole() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var role = sharedPreferences.getString("userRole");
    // print("THE ROLE OF THIS TOKEN IS");
    // print(role);
    return role;
  }

  @override
  void initState() {
    super.initState();
    var token = getToken();
    checkValue();
  }

  void showAlertDialog(BuildContext context, String title, String message,
      Widget widget, Color c) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 2.5),
      title: Center(
          child: Text(
        title,
        style: TextStyle(color: c),
      )),
      content: Center(child: Text(message)),
      actions: [
        widget,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("BUUUUUUUUUUUUUIIIIIIIIIIIIIIIIIILLLLLLLLLLLLLLL");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    const Color(0xff7786ed),
                    darkBlueColor,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(top: 130, left: 20),
                    // color: Color(0xFF2238c4).withOpacity(.85),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // showAlertDialog(context);
                          },
                          child: const Text(
                            "Hello There!!",
                            style: TextStyle(
                              fontSize: 28,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Widget okButton = FlatButton(
                                //   child: const Text("OK"),
                                //   onPressed: () {
                                //     //Navigator.pop(context);
                                //   },
                                // );
                                // showAlertDialog(
                                //     context,
                                //     "OOPS!!",
                                //     "Invalid Email / Password",
                                //     okButton,
                                //     Colors.red);
                              },
                              child: RichText(
                                text: TextSpan(
                                    text: "Welcome to",
                                    style: const TextStyle(
                                      fontSize: 21,
                                      letterSpacing: 2,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: " Grow",
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xfffe6700),
                                        ),
                                      ),
                                      TextSpan(
                                        text: isSignupScreen ? "Up" : "",
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: greenColor,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 110,
                  width: 70,
                  decoration: BoxDecoration(
                      color: orangeColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(90),
                          bottomRight: Radius.circular(90))),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    height: 85,
                    width: 70,
                    decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(90),
                            bottomRight: Radius.circular(90))),
                  ),
                )),
            Positioned(
                // alignment: Alignment.bottomRight,
                right: -12,
                bottom: -20,
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(90),
                          bottomLeft: Radius.circular(90),
                          topRight: Radius.circular(90))),
                )),
            // Positioned(
            //     bottom: 10,
            //     child: Container(
            //       height: 100,
            //       width: 100,
            //       color: orangeColor
            //     )),
            // Trick to add the shadow for the submit button
            buildBottomHalfContainer(true),
            //Main Contianer for Login and Signup
            AnimatedPositioned(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              top: isSignupScreen ? 200 : 230,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOut,
                height: isSignupScreen ? 420 : 270,
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          blurRadius: 9,
                          spreadRadius: 3),
                    ]),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = false;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: !isSignupScreen
                                          ? activeColor
                                          : textColor1),
                                ),
                                if (!isSignupScreen)
                                  Container(
                                      margin: const EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: orangeColor)
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = true;
                              });
                              // myController
                            },
                            child: Column(
                              children: [
                                Text(
                                  "SIGNUP",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSignupScreen
                                          ? activeColor
                                          : textColor1),
                                ),
                                if (isSignupScreen)
                                  Container(
                                      margin: const EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: orangeColor)
                              ],
                            ),
                          )
                        ],
                      ),
                      if (isSignupScreen) buildSignupSection(),
                      if (!isSignupScreen) buildSigninSection()
                    ],
                  ),
                ),
              ),
            ),
            // Trick to add the submit button
            buildBottomHalfContainer(false),
          ],
        ),
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.mail_outline, "example@gmail.com", false, true,
              email, TextInputType.emailAddress),
          emailError
              ? builldErrorText("Please enter valid email address")
              : Container(
                  height: 15,
                ),
          buildTextField(Icons.lock_outline, "**********", true, false,
              password, TextInputType.name),
          passwordError
              ? builldErrorText("Please enter valid password")
              : Container(
                  height: 15,
                ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDropDown(context),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Who are you?',
                  style: TextStyle(
                      color: textColor2,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    activeColor: textColor2,
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                  ),
                  Text("Remember me",
                      style: TextStyle(fontSize: 12, color: textColor1))
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgetPassword()));
                },
                child: Text("Forgot Password?",
                    style: TextStyle(fontSize: 12, color: textColor1)),
              )
            ],
          )
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.access_alarm, "Full Name", false, false,
              fullnameSignup, TextInputType.name),
          fullnameSignupError
              ? builldErrorText("Please enter valid fullname")
              : Container(
                  height: 15,
                ),
          buildTextField(Icons.email, "Email", false, true, emailSignup,
              TextInputType.emailAddress),
          emailSignupError
              ? builldErrorText("Please enter valid email address")
              : Container(
                  height: 15,
                ),
          buildTextField(Icons.lock_outline, "Password", true, false,
              passwordSignup, TextInputType.name),
          passwordSignupError
              ? builldErrorText("Please enter valid password")
              : Container(
                  height: 15,
                ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDropDown(context),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Who are you?',
                  style: TextStyle(
                      color: textColor2,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = true;
                      gender = "Male";
                      print("GENDER CHECK===================");
                      print(gender);
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: isMale ? textColor2 : Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color:
                                    isMale ? Colors.transparent : textColor1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          Icons.male,
                          color: isMale ? Colors.white : iconColor,
                        ),
                      ),
                      Text(
                        "Male",
                        style: TextStyle(color: textColor1),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = false;
                      gender = "Female";
                      print("GENDER CHECK===================");
                      print(gender);
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: isMale ? Colors.transparent : textColor2,
                            border: Border.all(
                                width: 1,
                                color:
                                    isMale ? textColor1 : Colors.transparent),
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          Icons.female,
                          color: isMale ? iconColor : Colors.white,
                        ),
                      ),
                      Text(
                        "Female",
                        style: TextStyle(color: textColor1),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 500,
            margin: const EdgeInsets.only(top: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "By signing up, you agree to our ",
                  style: TextStyle(color: textColor2),
                  children: const [
                    TextSpan(
                      //recognizer: ,
                      text: "term & conditions",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
// Widget buildDropDown(){

// }
  Widget builldErrorText(String name) {
    return Container(
      height: 15,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          name,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildDropDown(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: iconColor,
              boxShadow: const [
                BoxShadow(
                    color: Color(0xFFCCCCCC),
                    blurRadius: 14,
                    spreadRadius: -3,
                    offset: Offset(3, 7)),
              ]
              // color: Colors.amber,
              ),
          //  margin: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              DropdownButton<String>(
                items: _currencies.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (newValueSelected) {
                  _onDropDownItemSelected(newValueSelected!);
                },
                value: _currentItemSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      _currentItemSelected = newValueSelected;
      print("SELECTED CB: " + _currentItemSelected);
    });
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      // key: _formkey,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      top: isSignupScreen ? 575 : 440,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 80,
          width: 80,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 15,
                      spreadRadius: 3)
              ]),
          child: !showShadow
              ? GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLogging = true;
                    });
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => HomePageScreen()));
                    // Get.offAll(() => HomePageScreen());

                    if (!isSignupScreen) {
                      print("IS LOGIN");
                      if (email.text.toString().isEmpty &&
                          password.text.toString().isEmpty) {
                        checkErrorLoginEmail();
                        checkErrorLoginPassword();
                        setState(() {
                          isLogging = false;
                        });
                      } else {
                        String selected = _currentItemSelected;
                        switch (selected) {
                          case "Student":
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(email.text.toString())) {
                              checkErrorLoginEmail();
                              setState(() {
                                isLogging = false;
                              });
                              print("not successful");
                            } else if (password.text.toString().isEmpty) {
                              checkErrorLoginPassword();
                              setState(() {
                                isLogging = false;
                              });
                            } else {
                              print("successful logino");
                              String emailData = email.text.trim();
                              String passwordData = password.text;
                              print(
                                  "***************************************************************************");
                              print(tokenData);
                              if (tokenData != null) {
                                setState(() {
                                  isLogging = false;
                                });
                              }
                              var token =
                                  await login(emailData, passwordData) ??
                                      "EQWE";
                              if (token == "Invalid Password") {
                                Widget okButton = const Center(
                                  child: Icon(
                                    Iconsax.chart_fail,
                                    color: Colors.red,
                                  ),
                                );
                                showAlertDialog(
                                    context,
                                    "OOPS!!",
                                    "Invalid Email / Password",
                                    okButton,
                                    Colors.red);

                                setState(() {
                                  isLogging = false;
                                });
                                final SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.remove("tokenData");

                                final SharedPreferences sharedPreferences1 =
                                    await SharedPreferences.getInstance();
                                sharedPreferences1.remove("userRole");
                              } else {
                                //  if (await userRole == "Student") {
                                tokenData = token.message;
                                userRole = token.user;
                                print(
                                    "THE tokenData IS::::::::::::::::::::::::::::::::::::::::::::::::::");
                                print(userRole);
                                print(_currentItemSelected);
                                //  if (tokenData == "EQWE") {
                                //     } else {
                                final SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.setString(
                                    "tokenData", tokenData);

                                final SharedPreferences sharedPreferencesRole =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.setString(
                                    "userRole", userRole);

                                obtainedtokenData = tokenData;
                                setState(() {});
                                Widget okButton = const Center(
                                  child: Icon(
                                    Iconsax.tick_circle,
                                    color: Color.fromARGB(255, 57, 229, 0),
                                    size: 20,
                                  ),
                                );
                                showAlertDialog(
                                    context,
                                    "Success",
                                    "Login Successfull",
                                    okButton,
                                    const Color.fromARGB(255, 82, 196, 0));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Logged In'),
                                ));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePageScreen()));
                                tokenPass();
                                // } else {
                                //   setState(() {
                                //     isLogging = false;
                                //   });
                                //   Widget okButton = const Center(
                                //     child: Icon(
                                //       Iconsax.chart_fail,
                                //       color: Colors.red,
                                //     ),
                                //   );
                                //   showAlertDialog(
                                //       context,
                                //       "User Not found!!",
                                //       "No $_currentItemSelected found with this email",
                                //       okButton,
                                //       Colors.red);
                                // }
                              }
                              //  }
                            }
                            break;
                          case "Teacher":
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(email.text.toString())) {
                              checkErrorLoginEmail();
                              setState(() {
                                isLogging = false;
                              });
                              print("not successful");
                            } else if (password.text.toString().isEmpty) {
                              checkErrorLoginPassword();
                              setState(() {
                                isLogging = false;
                              });
                            } else {
                              print("successful login");
                              String emailData = email.text.trim();
                              String passwordData = password.text;
                              var token =
                                  await login(emailData, passwordData) ??
                                      "EQWE";
                              if (token == "Invalid Password") {
                                Widget okButton = const Center(
                                  child: Icon(
                                    Iconsax.chart_fail,
                                    color: Colors.red,
                                  ),
                                );
                                showAlertDialog(
                                    context,
                                    "OOPS!!",
                                    "Invalid Email / Password",
                                    okButton,
                                    Colors.red);

                                setState(() {
                                  isLogging = false;
                                });
                                final SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.remove("tokenData");

                                final SharedPreferences sharedPreferences1 =
                                    await SharedPreferences.getInstance();
                                sharedPreferences1.remove("userRole");
                              } else {
                                //  if (await userRole == "Student") {
                                tokenData = token.message;
                                userRole = token.user;
                                print(
                                    "THE tokenData IS::::::::::::::::::::::::::::::::::::::::::::::::::");
                                print(userRole);
                                print(_currentItemSelected);
                                //  if (tokenData == "EQWE") {
                                //     } else {
                                final SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.setString(
                                    "tokenData", tokenData);

                                final SharedPreferences sharedPreferencesRole =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.setString(
                                    "userRole", userRole);

                                obtainedtokenData = tokenData;
                                setState(() {});
                                Widget okButton = const Center(
                                  child: Icon(
                                    Iconsax.tick_circle,
                                    color: Color.fromARGB(255, 57, 229, 0),
                                    size: 20,
                                  ),
                                );
                                showAlertDialog(
                                    context,
                                    "Success",
                                    "Login Successfull",
                                    okButton,
                                    const Color.fromARGB(255, 82, 196, 0));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Logged In'),
                                ));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TeacherPage()));
                                tokenPass();
                              }
                            }
                            break;

                          default:
                        } // }
                      }
                    } else {
                      String selected = _currentItemSelected;
                      switch (selected) {
                        case "Student":
                          if (fullnameSignup.text.toString().isEmpty &&
                              emailSignup.text.toString().isEmpty &&
                              passwordSignup.text.toString().isEmpty) {
                            setState(() {
                              isLogging = false;
                            });
                            checkErrorEmail();
                            checkErrorfullname();
                            checkErrorPassword();
                          } else {
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(emailSignup.text.toString())) {
                              checkErrorEmail();
                              setState(() {
                                isLogging = false;
                              });
                              print("NOT  EMAIL");
                            } else if (!RegExp("^[a-zA-Z0-9]")
                                .hasMatch(fullnameSignup.text.toString())) {
                              checkErrorfullname();
                              setState(() {
                                isLogging = false;
                              });
                              print("yes fullname");
                            } else if (passwordSignup.text.toString().isEmpty) {
                              checkErrorPassword();
                              setState(() {
                                isLogging = false;
                              });
                            } else {
                              print("successful logino");
                              String fullname = fullnameSignup.text;
                              String emailData = emailSignup.text.trim();
                              String passwordData = passwordSignup.text;
                              var mytokenData = await register(
                                  emailData,
                                  passwordData,
                                  passwordData,
                                  fullname,
                                  gender!,
                                  "Address",
                                  "Student");
                              final SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setString("email", emailData);
                              await tokenDataStorage.write(
                                  key: "email", value: emailData);
                              print(
                                  "000000000000000000000000000000000000000000000000000000000000000");
                              print(mytokenData);
                              if (mytokenData != null) {
                                if (mytokenData ==
                                    "Account registered already") {
                                  setState(() {
                                    isLogging = false;
                                  });
                                  // Get.defaultDialog(
                                  //     title: "Unsuccessfull",
                                  //     middleText: "Account already existed",
                                  //     actions: [
                                  //       const Icon(Iconsax.chart_fail,
                                  //           size: 35, color: Colors.red)
                                  //     ],
                                  //     buttonColor: Colors.white);
                                  Widget okButton = const Center(
                                    child: Icon(
                                      Iconsax.chart_fail,
                                      color: Colors.red,
                                    ),
                                  );
                                  showAlertDialog(
                                      context,
                                      "Unsuccessfull",
                                      "Account already existed",
                                      okButton,
                                      Colors.red);
                                } else {
                                  setState(() {
                                    isLogging = false;
                                  });
                                  Widget okButton = const Center(
                                    child: Icon(
                                      Iconsax.tick_circle,
                                      color: Color.fromARGB(255, 57, 229, 0),
                                      size: 20,
                                    ),
                                  );
                                  showAlertDialog(
                                      context,
                                      "Success",
                                      "Registration Successfull",
                                      okButton,
                                      const Color.fromARGB(255, 82, 196, 0));
                                  //Get.off(LoginSignupScreen());
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const HomePageScreen()));
                                }
                              }

                              print("tokenData IS: $tokenDataStorage");
                            }
                          }
                          break;
                        case "Teacher":
                          if (fullnameSignup.text.toString().isEmpty &&
                              emailSignup.text.toString().isEmpty &&
                              passwordSignup.text.toString().isEmpty) {
                            checkErrorEmail();
                            checkErrorfullname();
                            checkErrorPassword();
                            setState(() {
                              isLogging = false;
                            });
                          } else {
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(emailSignup.text.toString())) {
                              checkErrorEmail();
                              setState(() {
                                isLogging = false;
                              });
                              print("NOT  EMAIL");
                            } else if (!RegExp("^[a-zA-Z0-9]")
                                .hasMatch(fullnameSignup.text.toString())) {
                              checkErrorfullname();
                              setState(() {
                                isLogging = false;
                              });
                              print("yes fullname");
                            } else if (passwordSignup.text.toString().isEmpty) {
                              checkErrorPassword();
                              setState(() {
                                isLogging = false;
                              });
                            } else {
                              print("successful logino");
                              String fullname = fullnameSignup.text;
                              String emailData = emailSignup.text.trim();
                              String passwordData = passwordSignup.text;
                              var mytokenData = await register(
                                  emailData,
                                  passwordData,
                                  passwordData,
                                  fullname,
                                  gender!,
                                  "Address",
                                  "Teacher");
                              final SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setString("email", emailData);
                              await tokenDataStorage.write(
                                  key: "email", value: emailData);
                              // Get.off(LoginSignupScreen());
                              print(
                                  "000000000000000000000000000000000000000000000000000000000000000");
                              print(mytokenData);
                              if (mytokenData != null) {
                                if (mytokenData ==
                                    "Account registered already") {
                                  setState(() {
                                    isLogging = false;
                                  });
                                  // Get.defaultDialog(
                                  //     title: "Unsuccessfull",
                                  //     middleText: "Account already existed",
                                  //     actions: [
                                  //       const Icon(Iconsax.chart_fail,
                                  //           size: 35, color: Colors.red)
                                  //     ],
                                  //     buttonColor: Colors.white);
                                  Widget okButton = const Center(
                                    child: Icon(
                                      Iconsax.chart_fail,
                                      color: Colors.red,
                                    ),
                                  );
                                  showAlertDialog(
                                      context,
                                      "Unsuccessfull",
                                      "Account already existed",
                                      okButton,
                                      Colors.red);
                                } else {
                                  setState(() {
                                    isLogging = false;
                                  });
                                  // Get.defaultDialog(
                                  //     title: "Success!!",
                                  //     middleText: "Registration Successfull",
                                  //     actions: [
                                  //       const Icon(
                                  //         Iconsax.tick_circle,
                                  //         size: 35,
                                  //         color:
                                  //             Color.fromARGB(255, 25, 202, 93),
                                  //       )
                                  //     ],
                                  //     buttonColor: Colors.white);
                                  Widget okButton = const Center(
                                    child: Icon(
                                      Iconsax.tick_circle,
                                      color: Color.fromARGB(255, 57, 229, 0),
                                      size: 20,
                                    ),
                                  );
                                  showAlertDialog(
                                      context,
                                      "Success",
                                      "Registration Successfull",
                                      okButton,
                                      const Color.fromARGB(255, 82, 196, 0));
                                  //Get.off(LoginSignupScreen());
                                }
                              }

                              print("tokenData IS: $tokenDataStorage");
                            }
                          }

                          break;
                      }
                      print("IS SIGNUP");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [darkBlueColor, const Color(0xff7786ed)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1))
                        ]),
                    child: isLogging
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                        : const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                  ),
                )
              : const Center(),
        ),
      ),
    );
  }

  Widget buildTextField(IconData icon, String hintText, bool isPassword,
      bool isEmail, TextEditingController controller, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: type,
        decoration: InputDecoration(
          // labelText: "NabinGurung",
          errorText: null,
          prefixIcon: Icon(
            icon,
            color: iconColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textColor1),
            borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textColor1),
            borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: const EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: textColor1),
        ),
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     print("====================================");
        //     print("object");
        //     setState(() {
        //       isValid = !isValid;
        //     });
        //     return 'Please Enter Name';
        //   }
        //   return null;
        // },
        // onSaved: (String? value) {
        //   textValue = value;
        // },
      ),
    );
  }

  void checkErrorEmail() {
    setState(() {
      emailSignupError = true;
    });
  }

  void checkErrorfullname() {
    setState(() {
      fullnameSignupError = true;
    });
  }

  void checkErrorPassword() {
    setState(() {
      passwordSignupError = true;
    });
  }

  void checkErrorLoginEmail() {
    setState(() {
      emailError = true;
    });
  }

  void checkErrorLoginPassword() {
    setState(() {
      passwordError = true;
    });
  }

  tokenPass() {
    return tokenData;
  }

  getToken() {
    return tokenPass();
  }
}
