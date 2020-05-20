import 'package:flutter/material.dart';

class HomeLower extends StatefulWidget {
  @override
  _HomeLowerState createState() => _HomeLowerState();
}

class _HomeLowerState extends State<HomeLower> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: MediaQuery.of(context).size.height * 0.35,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
      ),
    );
  }
}
