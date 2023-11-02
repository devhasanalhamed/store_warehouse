import 'package:flutter/material.dart';
import 'package:store_warehouse/core/shared/models/unit.dart';
import 'package:store_warehouse/core/utils/sql_helper.dart';

class UnitProvider extends ChangeNotifier {
  List<Unit> list = [
    // Unit(id: 0, title: 'بالحبة', unitPerPiece: 1),
    // Unit(id: 1, title: 'كرتون 24', unitPerPiece: 24),
    // Unit(id: 2, title: 'كرتون 12', unitPerPiece: 12),
  ];

  Future<int> addUnit(String title, int unitPerPiece) async {
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
      list = temp;
    }
    notifyListeners();
    return temp;
  }
}
