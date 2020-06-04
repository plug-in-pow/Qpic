import 'package:flutter/material.dart';
import 'package:smart_ai_captioner/components/photo_filter/bottom_body.dart';
import 'package:smart_ai_captioner/components/photo_filter/filter_body.dart';

class PhotoFilterS1 extends StatefulWidget {
  @override
  _PhotoFilterS1State createState() => _PhotoFilterS1State();
}

class _PhotoFilterS1State extends State<PhotoFilterS1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Filter",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.blue,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: FilterBody(),
      bottomSheet: BottomBody(),
    );
  }
}
