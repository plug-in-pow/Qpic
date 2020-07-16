import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:tflite/tflite.dart';

class FusionImageData extends ChangeNotifier {
  File _image;
  bool _modelLoaded = false;
  // List<ColorFilter> _filter = [];
  int _selectedFilterIndex = 0;

  setImage(File img) {
    _image = img;
    notifyListeners();
  }

  setFilter() {
    if (_image != null) {
      Tflite.loadModel(model: "assets/tflite/neural_style_transfer.tflite")
          .then((value) => {_modelLoaded = true})
          .catchError((err) => {});
      notifyListeners();
    }
  }

  // setFilterIndex(int index) {
  //   _selectedFilterIndex = index;
  //   notifyListeners();
  // }

  File getImage() => _image;
  // List<ColorFilter> getFilterList() => _filter;
  bool isModelLoaded() => _modelLoaded;
  int getFilterIndex() => _selectedFilterIndex;
}
