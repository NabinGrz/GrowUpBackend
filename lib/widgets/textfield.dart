import 'package:flutter/material.dart';
import 'package:growup/colorpalettes/palette.dart';

Widget buildTextField(IconData? icon, String hintText, bool isPassword,
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
          color: Colors.black,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkBlueColor),
          borderRadius: const BorderRadius.all(Radius.circular(35.0)),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 16, color: blackColor),
      ),
    ),
  );
}
