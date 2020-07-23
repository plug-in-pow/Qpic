import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_ai_captioner/components/common_functions/get_image.dart';

enum Source { camera, gallery }

Future<void> openDialogBox(BuildContext context, dynamic imageData) async {
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
      getImage(ImageSource.camera, imageData, Permission.camera);
      break;
    case Source.gallery:
      getImage(ImageSource.gallery, imageData, Permission.storage);
      break;
  }
}
