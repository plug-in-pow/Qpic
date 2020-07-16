import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_ai_captioner/components/photo_filter/Functions/get_image.dart';
import 'package:smart_ai_captioner/provider/filter_provider.dart';

enum Source { camera, gallery }

Future<void> openDialogBox(BuildContext context) async {
  var imageData = Provider.of<ImageData>(context, listen: false);
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

// Future<void> _successDialog(BuildContext context) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: Color(0xff1ad477),
//         title: Text(
//           'Alert',
//           style: TextStyle(color: Colors.white),
//         ),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Icon(Icons.done_outline, color: Colors.white),
//               Center(
//                   child: Text(
//                 "Saved Sucessfully",
//                 style: TextStyle(color: Colors.white),
//               )),
//               Center(
//                   child: Text(
//                 "At location '/storage/emulated/0/FotoApp/' ",
//                 style: TextStyle(color: Colors.white),
//               )),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           FlatButton(
//             child: Text(
//               'OK',
//               style: TextStyle(color: Colors.white),
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
