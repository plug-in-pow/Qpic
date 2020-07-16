import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

String _formattedDate() {
  String dateTimeString = 'FotoApp_' + DateTime.now().toUtc().toIso8601String();
  return dateTimeString;
}

Future<bool> saveScreen(GlobalKey key, BuildContext context) async {
  try {
    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var png = byteData.buffer.asUint8List();
    await Directory('/storage/emulated/0/FotoApp').create(recursive: true);
    File('/storage/emulated/0/FotoApp/${_formattedDate()}.png')
        .writeAsBytesSync(png.buffer.asInt8List());

    return true;
  } catch (e) {
    return false;
  }
}
