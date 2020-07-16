import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
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
            "Success",
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
              'assets/undraw_order_confirmed_aaw7.png',
            ),
            Center(
              child: Text(
                "Well done ! \n File saved successfully.",
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
