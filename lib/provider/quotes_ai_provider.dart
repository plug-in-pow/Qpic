import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:tflite/tflite.dart';

class QuotesAiImageData extends ChangeNotifier {
  File _image;
  List<String> _recognition = [];

  setRecognization() async {
    if (_image == null) return;
    try {
      await Tflite.loadModel(
          model: "assets/tflite/yolov2_tiny.tflite",
          labels: "assets/tflite/yolov2_tiny_labels.txt");

      var rec1 = await Tflite.detectObjectOnImage(
          path: _image.path,
          model: "YOLO",
          threshold: 0.3,
          imageMean: 0.0,
          imageStd: 255.0,
          numResultsPerClass: 6,
          asynch: true);

      await Tflite.loadModel(
        model: "assets/tflite/mobilenet_v1_1.0_224.tflite",
        labels: "assets/tflite/mobilenet_v1_1.0_224_labels.txt",
      );

      var rec2 = await Tflite.runModelOnImage(
        path: _image.path,
        numResults: 6,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      for (int i = 0; i < rec1.length; i++) {
        _recognition.add(rec1[i]["detectedClass"]);
      }

      for (int i = 0; i < rec2.length; i++) {
        if (rec2[i]["confidence"] >= 0.50) {
          _recognition.add(rec2[i]["label"]);
        }
      }

      _recognition = _recognition.toSet().toList();

      if (_recognition.length == 0) {
        _recognition.addAll(["quote", "world"]);
      }

      _recognition.shuffle();

      print(_recognition);

      notifyListeners();

      await Tflite.close();
    } catch (e) {
      _recognition.add("Error");
      notifyListeners();
    }
  }

  setImage(File img) {
    _image = img;
    notifyListeners();
  }

  File getImage() => _image;
  List<String> getRecognitions() => _recognition;
}
