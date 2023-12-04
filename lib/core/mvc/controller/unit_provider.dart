import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store_warehouse/core/mvc/models/unit.dart';
import 'package:store_warehouse/core/utils/sql_helper.dart';
import 'package:store_warehouse/core/utils/sql_unit.dart';

class UnitProvider extends ChangeNotifier {
  // Future<int> addUnit(String title, int unitPerPiece) async {
  //   notifyListeners();
  //   return await SQLUnitHelper.createUnit(title, unitPerPiece);
  // }

  Future<List<Unit>> getUnits() async {
    List<Unit> temp = [];
    final dbList = await SQLUnitHelper.getUnits();
    log(dbList.toString());
    for (var element in dbList) {
      temp.add(
        Unit(
          id: element['id'],
          title: element['title'],
          unitPerPiece: element['unitPerPiece'],
        ),
      );
    }
    log('unit: ${temp.length}');
    return temp;
  }

  Future<void> deleteDatabase() async {
    SQLHelper.deleteDB();
    notifyListeners();
  }
}
