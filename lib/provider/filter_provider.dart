import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ImageData extends ChangeNotifier {
  File _image;
  List<ColorFilter> _filter = [
    ColorFilter.mode(Colors.blue[50], BlendMode.softLight),
    ColorFilter.mode(Color(0xffffffe6), BlendMode.softLight),
    ColorFilter.mode(Color(0xffe6f9ff), BlendMode.saturation),
    ColorFilter.matrix(<double>[
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]),
    ColorFilter.matrix(<double>[
      1.5,
      1.5,
      1.5,
      0,
      0,
      1.5,
      1.5,
      1.5,
      0,
      0,
      1.5,
      1.5,
      1.5,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]),
    ColorFilter.matrix(<double>[
      -1,
      0,
      0,
      0,
      255,
      0,
      -1,
      0,
      0,
      255,
      0,
      0,
      -1,
      0,
      255,
      0,
      0,
      0,
      1,
      0,
    ]),
  ];
  int _selectedFilterIndex = 0;

  setImage(File img) {
    _image = img;
    notifyListeners();
  }

  setFilterIndex(int index) {
    _selectedFilterIndex = index;
    notifyListeners();
  }

  File getImage() => _image;
  List<ColorFilter> getFilterList() => _filter;
  int getFilterIndex() => _selectedFilterIndex;
}
