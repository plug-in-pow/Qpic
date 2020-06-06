import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:smart_ai_captioner/provider/filter_provider.dart';

enum Source { camera, gallery }

class FilterBody extends StatefulWidget {
  @override
  _FilterBodyState createState() => _FilterBodyState();
}

class _FilterBodyState extends State<FilterBody> {
  final picker = ImagePicker();

  Future<void> _openDialogBox() async {
    switch (await showDialog<Source>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Source'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Source.camera);
                },
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.camera),
                    SizedBox(
                      width: 10,
                    ),
                    const Text('Camera'),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Source.gallery);
                },
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.folder),
                    SizedBox(
                      width: 10,
                    ),
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

  void _checkPermission() async {
    if (await Permission.storage.status.isUndetermined) {
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

    if (await Permission.camera.status.isUndetermined) {
      Permission.storage.request();
    }

    if (await Permission.camera.isRestricted) {
      openAppSettings();
    }

    if (await Permission.camera.request().isGranted) {
      return;
    }

    if (await Permission.camera.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future getImage(ImageSource source) async {
    var imageData = Provider.of<ImageData>(context, listen: false);
    final pickedFile = await picker.getImage(source: source);
    imageData.setImage(File(pickedFile.path));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageData>(
      builder: (context, data, _) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.60,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(40),
            color: Colors.grey[300],
          ),
          child: data.getImage() != null
              ? ClipRRect(
                  //borderRadius: BorderRadius.circular(40),
                  child: ColorFiltered(
                    colorFilter: data.getFilterList()[data.getFilterIndex()],
                    child: Image.file(
                      data.getImage(),
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : FlatButton.icon(
                  onPressed: () {
                    // _checkPermission();
                    _openDialogBox();
                  },
                  icon: Icon(Icons.add_a_photo),
                  label: Text("Add a Photo"),
                ),
        );
      },
    );
  }
}
