import 'package:flutter/material.dart';
import 'package:growup/colorpalettes/palette.dart';

class DropDown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DropDownState();
  }
}

class _DropDownState extends State {
  final _currencies = ['Student', 'Teacher'];
  var _currentItemSelected = 'Student';

  @override
  Widget build(BuildContext context) {
    print("BUUUUUUUUUUUUUIIIIIIIIIIIIIIIIIILLLLLLLLLLLLLLL");
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
                onChanged: (newValueSelected) {},
                value: _currentItemSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      _currentItemSelected = newValueSelected;
    });
    return newValueSelected;
  }
}
