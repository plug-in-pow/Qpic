import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imageLib;

import 'package:photofilters/photofilters.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:smart_ai_captioner/components/photo_filter/filter_selector.dart';

enum Source { camera, gallery }

List<Widget> cacheImageWidget = [];

class PhotoFilterS1 extends StatefulWidget {
  @override
  _PhotoFilterS1State createState() => _PhotoFilterS1State();
}

class _PhotoFilterS1State extends State<PhotoFilterS1> {
  Filter _filter;
  Map<String, List<int>> cachedFilters = {};
  Widget loader = Center(child: CircularProgressIndicator());
  imageLib.Image _image;
  String fileName;
  final picker = ImagePicker();
  List<Filter> filters = presetFiltersList;
  bool _isImageSelected = false;
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getImage(ImageSource source) async {
    var imageFile = await picker.getImage(source: source);

    if (imageFile != null) {
      fileName = Path.basename(imageFile.path);
      var image = imageLib.decodeImage(await imageFile.readAsBytes());
      setState(() {
        _image = image;
        _isImageSelected = true;
      });
    }
  }

  Future<void> _showMyDialog() async {
    switch (await showDialog<Source>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select source'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Source.camera);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.camera_enhance),
                    SizedBox(width: 20),
                    const Text('Camera'),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Source.gallery);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.folder),
                    SizedBox(width: 20),
                    const Text('Gallery'),
                  ],
                ),
              ),
            ],
          );
        })) {
      case Source.camera:
        getImage(ImageSource.camera);
        break;
      case Source.gallery:
        getImage(ImageSource.gallery);
        break;
    }
  }

  Widget getSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          getSizedBox(40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  "Filter",
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () async {
                    // var imageFile =
                    await saveFilteredImage();
                    // var imageBytes = await imageFile.readAsBytes();
                    // final res = await _imageSaver.saveImage(
                    //   imageBytes: imageBytes,
                    //   directoryName: "Foto_app",
                    // );
                    debugPrint("completed");
                  },
                ),
              ],
            ),
          ),
          getSizedBox(10),
          Container(
            height: MediaQuery.of(context).size.height * 0.60,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.grey[300],
            ),
            child: !_isImageSelected
                ? FlatButton.icon(
                    onPressed: () {
                      if (!_isImageSelected) {
                        _showMyDialog();
                      }
                    },
                    icon: Icon(Icons.add_a_photo),
                    label: Text("add photo"))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: _buildFilterImage(
                        presetFiltersList[_currentTab], _image, fileName),
                  ),
          )
        ],
      ),
      bottomSheet: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: _isImageSelected
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentTab = index;
                          _filter = filters[index];
                          debugPrint("$_currentTab");
                        });
                      },
                      child: Container(
                        width: 70,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: _currentTab == index
                                ? Border.all(
                                    color: Colors.blueAccent,
                                    width: 3.0,
                                  )
                                : null),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: _buildFilterImage(
                            presetFiltersList[index],
                            _image,
                            fileName,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(child: Text("No Image selected"))),
    );
  }

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/foto_app_$fileName');
  }

  Future<File> saveFilteredImage() async {
    var imageFile = await _localFile;
    await imageFile.writeAsBytes(cachedFilters[_filter?.name ?? "_"]);
    return imageFile;
  }

  Widget _buildFilterImage(
      Filter filter, imageLib.Image image, String filename) {
    if (cachedFilters[filter?.name ?? "_"] == null) {
      return FutureBuilder<List<int>>(
        future: compute(applyFilter, <String, dynamic>{
          "filter": filter,
          "image": image,
          "filename": filename,
        }),
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return loader;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return loader;
            case ConnectionState.done:
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              cachedFilters[filter?.name ?? "_"] = snapshot.data;
              return Image.memory(
                snapshot.data,
                fit: BoxFit.cover,
              );
          }
          return null; // unreachable
        },
      );
    } else {
      return Image.memory(
        cachedFilters[filter?.name ?? "_"],
        fit: BoxFit.cover,
      );
    }
  }
}

///The global applyfilter function
List<int> applyFilter(Map<String, dynamic> params) {
  Filter filter = params["filter"];
  imageLib.Image image = params["image"];
  String filename = params["filename"];
  List<int> _bytes = image.getBytes();
  if (filter != null) {
    filter.apply(_bytes);
  }
  imageLib.Image _image =
      imageLib.Image.fromBytes(image.width, image.height, _bytes);
  _bytes = imageLib.encodeNamedImage(_image, filename);

  return _bytes;
}
