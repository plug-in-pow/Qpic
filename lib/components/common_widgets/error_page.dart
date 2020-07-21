import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Failed",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/undraw_warning_cyit.png',
            ),
            Center(
              child: Text(
                "Sorry\n Unable to save image.",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
