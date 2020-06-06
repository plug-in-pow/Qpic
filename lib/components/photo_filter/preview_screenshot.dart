import 'dart:typed_data';

import 'package:flutter/material.dart';

class PreviewScreenshot extends StatelessWidget {
  final Uint8List photo;
  const PreviewScreenshot({Key key, this.photo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.memory(photo),
    );
  }
}
