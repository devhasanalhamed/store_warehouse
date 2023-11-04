import 'package:flutter/material.dart';
import 'package:store_warehouse/core/mvc/models/unit.dart';
import 'package:store_warehouse/core/utils/sql_helper.dart';

class UnitProvider extends ChangeNotifier {
  Future<int> addUnit(String title, int unitPerPiece) async {
    notifyListeners();
    return await SQLHelper.createUnit(title, unitPerPiece);
  }

  Future<List<Unit>> getUnits() async {
    List<Unit> temp = [];
    final dbList = await SQLHelper.getUnits();
    for (var element in dbList) {
      temp.add(
        Unit(
          id: element['id'],
          title: element['title'],
          unitPerPiece: element['unitPerPiece'],
        ),
      );
    }
    return temp;
  }

  Future<int> deleteDB(String title, int unitPerPiece) async {
    notifyListeners();
    return await SQLHelper.createUnit(title, unitPerPiece);
  }
}
