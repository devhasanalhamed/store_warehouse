import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  Future<void> restoreDB() async {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    var status1 = await Permission.storage.status;
    if (!status1.isGranted) {
      await Permission.storage.request();
    }

    try {
      File savedDBFile = File('/storage/emulated/0/InventoryBackup/inventory');
      await savedDBFile
          .copy('/data/user/0/com.example.store_warehouse/databases/inventory');
      print('restore success');
    } catch (error) {
      print('restore error');
    }
  }

  Future<void> backupDB() async {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    var status1 = await Permission.storage.status;
    if (!status1.isGranted) {
      await Permission.storage.request();
    }

    try {
      File ourDBFile =
          File('/data/user/0/com.example.store_warehouse/databases/inventory');
      Directory? folderPathForDBFile =
          Directory('/storage/emulated/0/InventoryBackup/');
      await folderPathForDBFile.create();
      Directory? folderPathForHistoryDBFile =
          Directory('/storage/emulated/0/InventoryBackup/history');
      await folderPathForHistoryDBFile.create();
      await ourDBFile.copy('/storage/emulated/0/InventoryBackup/inventory');
      await ourDBFile.copy(
          '/storage/emulated/0/InventoryBackup/history/inventory_${DateTime.now().month}_${DateTime.now().day}_${DateTime.now().minute}_${DateTime.now().second}');
      print('backup success');
    } catch (error) {
      print('backup error');
    }
  }

  Future<void> getDbPath() async {
    final String getDatabasePath = await getDatabasesPath();
    print('==================== Db Path: $getDatabasePath');
    print(
        '==================== Databases: ${Directory(getDatabasePath).listSync()}');
    Directory? getExternalPath = await getExternalStorageDirectory();
    print('==================== External Path: $getExternalPath');
  }
}
