import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_ai_captioner/splash_state.dart';

// App run from here
void main() {
  runApp(MyApp());
}

// Root in the Widget Tree
class MyApp extends StatelessWidget {
  // To prevent rotation of the screen
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Overlay the notification and navigation bar with Scaffold background
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),

      // Root Material App
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'AppFontFamily'),
        home: SplashState(),
      ),
    );
  }
}
