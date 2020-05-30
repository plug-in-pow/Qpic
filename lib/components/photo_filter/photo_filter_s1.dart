import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

// import 'package:photofilters/photofilters.dart';
import 'package:image_picker/image_picker.dart';

enum Department { camera, gallery }

class PhotoFilterS1 extends StatefulWidget {
  @override
  _PhotoFilterS1State createState() => _PhotoFilterS1State();
}

class _PhotoFilterS1State extends State<PhotoFilterS1> {
  File _image;
  final picker = ImagePicker();
  bool _isImageSelected = false;
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      _image = File(pickedFile.path);
      _isImageSelected = !_isImageSelected;
    });
  }

  Future<void> _showMyDialog() async {
    switch (await showDialog<Department>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select assignment'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Department.camera);
                },
                child: const Text('Treasury department'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Department.gallery);
                },
                child: const Text('State department'),
              ),
            ],
          );
        })) {
      case Department.camera:
        getImage(ImageSource.camera);
        break;
      case Department.gallery:
        getImage(ImageSource.gallery);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
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
                  icon: Icon(Icons.undo),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              _showMyDialog();
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.grey[300]),
              child: _isImageSelected
                  ? Icon(
                      Icons.add_a_photo,
                    )
                  : Image.file(
                      _image,
                      fit: BoxFit.fill,
                    ),
            ),
          )
        ],
      ),
      bottomSheet: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 17,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentTab = index;
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
                  child: Image.asset(
                    "assets/Ai_caption.png",
                    height: double.maxFinite,
                    width: double.maxFinite,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              );
            },
          )),
    );
  }
}
