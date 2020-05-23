import 'package:flutter/material.dart';

class HomeUpper extends StatefulWidget {
  const HomeUpper({this.toggle});
  final ToggleCallback toggle;
  @override
  _HomeUpperState createState() => _HomeUpperState();
}

class _HomeUpperState extends State<HomeUpper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [const Color(0xff4e54c8), Color(0xff8f94fb)],
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: widget.toggle,
                  child: Image.asset(
                    'assets/icons/align-left.png',
                    color: Colors.white,
                    height: 30,
                    width: 30,
                  ),
                ),
                Icon(
                  Icons.add_a_photo,
                  size: 30,
                  color: Colors.white,
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Welcome",
              style: TextStyle(color: Colors.white, fontSize: 45),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Apply Magic to your photos",
              style: TextStyle(
                  color: Colors.grey[350], fontSize: 15, wordSpacing: 5),
            ),
          )
        ],
      ),
    );
  }
}

typedef ToggleCallback = void Function();
