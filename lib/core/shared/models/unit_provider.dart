import 'dart:math';

import 'package:flutter/material.dart';
import 'package:store_warehouse/core/shared/models/unit.dart';

class UnitProvider extends ChangeNotifier {
  final List<Unit> list = [
    Unit(id: 0, title: 'بالحبة', unitPerPiece: 1),
    Unit(id: 1, title: 'كرتون 24', unitPerPiece: 24),
    Unit(id: 2, title: 'كرتون 12', unitPerPiece: 12),
  ];

  Future<void> addUnit(String title, int unitPerPiece) async {
    list.add(
      Unit(
        id: Random().nextInt(5000) + 2,
        title: title,
        unitPerPiece: unitPerPiece,
      ),
    );
  }
}
