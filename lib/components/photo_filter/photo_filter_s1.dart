import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_ai_captioner/components/photo_filter/bottom_body.dart';
import 'package:smart_ai_captioner/components/photo_filter/filter_body.dart';
import 'package:provider/provider.dart';
import 'package:smart_ai_captioner/components/photo_filter/preview_screenshot.dart';
import 'package:smart_ai_captioner/provider/filter_provider.dart';

class PhotoFilterS1 extends StatefulWidget {
  @override
  _PhotoFilterS1State createState() => _PhotoFilterS1State();
}

class _PhotoFilterS1State extends State<PhotoFilterS1> {
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
          "Filter",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          Consumer<ImageData>(
            builder: (context, data, _) {
              return IconButton(
                disabledColor: Colors.grey,
                icon: Icon(
                  Icons.save,
                  color: data.getImage() != null ? Colors.blue : null,
                ),
                onPressed: data.getImage() != null
                    ? () {
                        _checkPermission();
                        _saveScreen(previewContainer);
                      }
                    : null,
              );
            },
          ),
        ],
      ),
      body: RepaintBoundary(key: previewContainer, child: FilterBody()),
      bottomSheet: BottomBody(),
    );
  }

  void _checkPermission() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      Permission.storage.request();
    }

    if (await Permission.storage.isRestricted) {
      openAppSettings();
    }

    if (await Permission.storage.request().isGranted) {
      return;
    }

    if (await Permission.storage.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  String formattedDate() {
    String dateTimeString =
        'FotoApp_' + DateTime.now().toUtc().toIso8601String();
    return dateTimeString;
  }

  Future<void> _saveScreen(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var png = byteData.buffer.asUint8List();
      await Directory('/storage/emulated/0/FotoApp').create(recursive: true);
      File('/storage/emulated/0/FotoApp/${formattedDate()}.png')
          .writeAsBytesSync(png.buffer.asInt8List());
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => new PreviewScreenshot(photo: png),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
