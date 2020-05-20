import 'package:flutter/material.dart';

// Components
import 'package:smart_ai_captioner/components/home_components/home_upper.dart';
import 'package:smart_ai_captioner/components/home_components/home_lower.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[HomeUpper(), HomeLower()],
      ),
    );
  }
}
