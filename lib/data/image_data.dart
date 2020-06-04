import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;

class ImageData extends ChangeNotifier {
  String fileName;
  int _selectedFilter = 0;
  List<int> _filterImages = [];
  bool _imageSelected = false;
  imageLib.Image _img;

  int getFilterIndex() => _selectedFilter;
  bool getimageSelected() => _imageSelected;
  List<int> getFilterImage() => _filterImages;

  setImage(imageLib.Image image) {
    _img = image;
    _imageSelected = true;
    notifyListeners();
  }

  setFilter(String filename, Filter filter) {
    var tempImg = _img;
    fileName = filename;
    List<int> _bytes = tempImg.getBytes();
    if (filter != null) {
      filter.apply(_bytes);
    }
    imageLib.Image _image =
        imageLib.Image.fromBytes(tempImg.width, tempImg.height, _bytes);
    _bytes = imageLib.encodeNamedImage(_image, filename);
    _filterImages = _bytes;
    _bytes = null;
    notifyListeners();
  }

  setFilterByIndex(int index) {
    var tempImg = _img;
    List<int> _bytes = tempImg.getBytes();
    if (presetFiltersList[index] != null) {
      presetFiltersList[index].apply(_bytes);
    }
    imageLib.Image _image =
        imageLib.Image.fromBytes(tempImg.width, tempImg.height, _bytes);
    _bytes = imageLib.encodeNamedImage(_image, fileName);
    _filterImages = _bytes;
    _bytes = null;
    notifyListeners();
  }

  setFilterIndex(int index) {
    _selectedFilter = index;
    notifyListeners();
  }
}
