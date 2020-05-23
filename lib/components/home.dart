import 'package:flutter/material.dart';

// Components
import 'package:smart_ai_captioner/components/home_components/home_upper.dart';
import 'package:smart_ai_captioner/components/home_components/home_lower.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final double maxSlide = 225.0;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  void toggleState() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        double slide = maxSlide * animationController.value;
        double scale = 1 - (animationController.value * 0.3);
        return Scaffold(
          backgroundColor: Colors.blueAccent,
          body: Stack(children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(70.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Foto App"),
                    Text("Foto App"),
                    Text("Foto App"),
                    Text("Foto App"),
                    Text("Foto App"),
                  ],
                ),
              ),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(slide)
                ..scale(scale),
              alignment: Alignment.centerLeft,
              child: Scaffold(
                body: new Stack(
                  children: <Widget>[
                    HomeUpper(toggle: () {
                      toggleState();
                    }),
                    HomeLower()
                  ],
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
