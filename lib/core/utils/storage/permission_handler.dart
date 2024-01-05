import 'package:permission_handler/permission_handler.dart';

Future<bool> requestStoragePermission() async {
  var externalStoragePermission = await Permission.manageExternalStorage.status;
  if (!externalStoragePermission.isGranted) {
    final permissionStatus = await Permission.manageExternalStorage.request();
    externalStoragePermission = permissionStatus;
  }
  var storagePermission = await Permission.storage.status;
  if (!storagePermission.isGranted) {
    final permissionStatus = await Permission.storage.request();
    storagePermission = permissionStatus;
  }
  if (externalStoragePermission.isGranted || storagePermission.isGranted) {
    return true;
  }
  return false;
}
