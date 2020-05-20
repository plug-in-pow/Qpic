import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Transition Route
import 'package:smart_ai_captioner/transition/fade_into.dart';

// Screens
import 'package:smart_ai_captioner/components/intro_screen.dart';
import 'package:smart_ai_captioner/components/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Bree Serif'),
      title: 'Ai App',
      home: SplashState(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashState extends StatefulWidget {
  @override
  _SplashStateState createState() => _SplashStateState();
}

class _SplashStateState extends State<SplashState> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.pushReplacement(context, FadeRoute(page: Home()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.pushReplacement(context, FadeRoute(page: IntroScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 200), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
    );
  }
}
