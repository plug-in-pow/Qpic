import 'package:permission_handler/permission_handler.dart';

Future<bool> permissionHandling(
    PermissionStatus status, Permission permission) async {
  if (status.isUndetermined || status.isDenied) {
    var newStatus = await permission.request();
    if (newStatus.isUndetermined) {
      openAppSettings();
      return false;
    } else if (newStatus.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  if (status.isRestricted) {
    openAppSettings();
    return false;
  }

  if (status.isPermanentlyDenied) {
    openAppSettings();
    return false;
  }

  if (status.isGranted) {
    return true;
  }

  return false;
}
