import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Text(
          "Setting's",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40),
        ),
        SizedBox(
          height: 40,
        ),
        Divider(
          color: Colors.black,
          indent: 20.0,
          endIndent: 20.0,
        ),
      ],
    );
  }
}
