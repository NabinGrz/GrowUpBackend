import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EsewaClass extends StatefulWidget {
  const EsewaClass({Key? key}) : super(key: key);

  @override
  State<EsewaClass> createState() => _EsewaClassState();
}

class _EsewaClassState extends State<EsewaClass> {
  ESewaPnp? _esewaPnp;
  ESewaConfiguration? _configuration;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _configuration = ESewaConfiguration(
      clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
      secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
      environment: ESewaConfiguration.ENVIRONMENT_TEST,
    );
    _esewaPnp = ESewaPnp(configuration: _configuration!);
    //_initPayment("asdasd");
  }

/*
9806800001
Nepal@123
 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: ESewaPaymentButton(
          _esewaPnp!,
          amount: 10,
          callBackURL: "https://example.com",
          productId: "abc123",
          productName: "Flutter SDK Example",
          onSuccess: (result) {
            print("sssssssssssssssssssssssssssssssssss");
            Fluttertoast.showToast(msg: "The payment is success");
          },
          onFailure: (e) {
            Fluttertoast.showToast(msg: "The payment is nooooot success");
          },
        ),
      ),
    ));
  }
}
