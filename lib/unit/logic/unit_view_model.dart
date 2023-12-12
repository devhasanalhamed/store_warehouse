import 'package:flutter/material.dart';
import 'package:store_warehouse/core/database/dao/unit_dao.dart';
import 'package:store_warehouse/unit/data/unit_model.dart';

class UnitViewModel extends ChangeNotifier {
  List<UnitModel> unitList = [];

  Future<void> getUnits() async {
    final data = await UnitDAO().fetchUnits();
    unitList = data;
    notifyListeners();
  }

  ///[can be fetched from database]
  // Future<void> getUnitById() async {
  //   final data = await UnitDAO().fetchUnitNameById();
  //   notifyListeners();
  // }

  UnitModel getUnitById(int id) {
    return unitList.firstWhere((element) => element.id == id);
  }
}
