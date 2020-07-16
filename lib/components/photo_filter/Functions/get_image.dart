import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_ai_captioner/components/permission_handling.dart';

Future getImage(
    ImageSource source, dynamic imageData, Permission permissionType) async {
  final picker = ImagePicker();

  var status = await permissionType.status;

  if (await permissionHandling(status, permissionType)) {
    picker
        .getImage(source: source)
        .then((pickedFile) => {imageData.setImage(File(pickedFile.path))})
        .catchError((err) => {});
  }
}
