import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_warehouse/core/database/db_config.dart';
import 'package:store_warehouse/core/utils/storage/backup_path.dart';
import 'package:store_warehouse/core/utils/storage/permission_handler.dart';

class SQLHelper {
  Future<void> restoreDB() async {
    final permission = await requestStoragePermission();
    final databasePath = await getDatabasesPath();
    const databaseName = DbConfig.databaseName;
    if (permission) {
      try {
        File savedDBFile =
            File('/storage/emulated/0/InventoryBackup/$databaseName');
        await savedDBFile.copy('$databasePath/$databaseName');
      } catch (error) {
        print('restore error: $error');
      }
    }
  }

  Future<void> backupDB() async {
    final permission = await requestStoragePermission();
    final databasePath = await getDatabasesPath();
    const databaseName = DbConfig.databaseName;
    final backupDir = await getBackupPath();
    final historyDir = await getBackupHistoryPath();

    if (permission) {
      try {
        File ourDBFile = File('$databasePath/$databaseName');
        await ourDBFile.copy('$backupDir/$databaseName');
        await ourDBFile.copy(
            '$historyDir/inventory_${DateTime.now().month}_${DateTime.now().day}_${DateTime.now().minute}_${DateTime.now().second}');
      } catch (error) {
        debugPrint('backup error: $error');
      }
    }
  }

  Future<String> getLastBackup() async {
    final permission = await requestStoragePermission();
    final backupDir = await getBackupPath();
    const databaseName = DbConfig.databaseName;

    if (permission) {
      if (File('$backupDir/$databaseName').existsSync()) {
        return DateFormat.yMd()
            .format(File('$backupDir/$databaseName').lastModifiedSync());
      }
    }
    return 'doesNotExists'.tr();
  }
}
