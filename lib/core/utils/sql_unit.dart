import 'dart:developer';

import 'package:store_warehouse/core/utils/sql_helper.dart';

class SQLUnitHelper {
  // static Future<int> createUnit(String title, int unitPerPiece) async {
  //   final db = await SQLHelper.db();

  //   final data = {
  //     "title": title,
  //     "unitPerPiece": unitPerPiece,
  //   };

  //   final id = await db.insert('units', data,
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  //   return id;
  // }

  static Future<List<Map<String, dynamic>>> getUnits() async {
    log('getUnits Function');
    final db = await SQLHelper.db();
    return db.query('units', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getUnitById(int unitId) async {
    final db = await SQLHelper.db();
    return db.query('units',
        orderBy: 'id', limit: 1, where: 'id = ?', whereArgs: [unitId]);
  }
}
