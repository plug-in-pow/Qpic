// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:smart_ai_captioner/components/quotes_ai/quotes_ai_body.dart';
import 'package:smart_ai_captioner/components/quotes_ai/quotes_ai_bottom_body.dart';
import 'package:smart_ai_captioner/components/quotes_ai/quotes_ai_floatingbutton.dart';

class QuotesAiS1 extends StatefulWidget {
  @override
  _QuotesAiS1State createState() => _QuotesAiS1State();
}

class _QuotesAiS1State extends State<QuotesAiS1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey previewContainer = new GlobalKey();
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
            "Quotes AI",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: RepaintBoundary(key: previewContainer, child: QuotesAiBody()),
        bottomSheet: QuotesAiBottomBody(),
        floatingActionButton: QuotesAiFloatingButton());
  }
}
