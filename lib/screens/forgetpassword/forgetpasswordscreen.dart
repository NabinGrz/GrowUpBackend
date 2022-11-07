import 'package:flutter/material.dart';
import 'package:growup/services/resetpassword.dart';

import '../../colorpalettes/palette.dart';
import '../../widgets/textfield.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool isSuccess = false;
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        title: const Text("Forget Password"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            //color: Colors.red,
            child: buildTextField(Icons.email, "Your email", false, false,
                passwordController, TextInputType.emailAddress),
          ),
          Container(
            width: 180,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffFE876C),
                  Color(0xffFD5D37),
                ],
              ),
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
            child: FlatButton(
                onPressed: () async {
                  setState(() {
                    isSuccess = true;
                  });
                  bool password = await forgetPassword(passwordController.text);
                  if (password) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'Reset Password Link has been send to your mail.'),
                    ));
                    setState(() {
                      isSuccess = false;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Something went wrong'),
                    ));
                    setState(() {
                      isSuccess = false;
                    });
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                child: !isSuccess
                    ? Text(
                        'Reset Password',
                        style: whiteTextStyle.copyWith(fontSize: 18),
                      )
                    : const CircularProgressIndicator(
                        color: Colors.white,
                      )),
          ),
        ],
      ),
    );
  }
}
