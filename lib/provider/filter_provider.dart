import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ImageData extends ChangeNotifier {
  File _image;
  List<ColorFilter> _filter = [
    ColorFilter.mode(Color(0xffe6f9ff), BlendMode.softLight),
    ColorFilter.mode(Color(0xffe6f9ff), BlendMode.saturation),
    ColorFilter.mode(Color(0xffe6f9ff), BlendMode.srcIn),
    ColorFilter.mode(Color(0xffe6f9ff), BlendMode.srcOut),
    ColorFilter.mode(Color(0xffe6f9ff), BlendMode.darken),
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
