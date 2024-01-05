import 'dart:io';

import 'package:path_provider/path_provider.dart';

const String backupDirectory = 'InventoryBackup';
const String historyDirectory = 'history';

Future<String> getBackupPath() async {
  final externalDir = await getExternalStorageDirectory();
  final backupDire =
      await Directory('${externalDir!.path}/$backupDirectory').create();
  return backupDire.path;
}

Future<String> getBackupHistoryPath() async {
  final externalDir = await getExternalStorageDirectory();
  final historyDir =
      await Directory('${externalDir!.path}/$backupDirectory/$historyDirectory')
          .create();
  return historyDir.path;
}
