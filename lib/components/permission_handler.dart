import 'package:permission_handler/permission_handler.dart';

Future<bool> getStatus(Permission permision) async {
  var status = await permision.status;
  if (status == PermissionStatus.granted) {
    return true;
  } else {
    status = await permision.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
