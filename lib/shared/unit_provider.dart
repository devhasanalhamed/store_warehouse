import 'dart:math';

import 'package:flutter/material.dart';
import 'package:store_warehouse/shared/unit.dart';

class UnitProvider extends ChangeNotifier {
  final List<Unit> list = [
    const Unit(id: 0, title: 'بالحبة', unitPerPiece: 1),
    const Unit(id: 1, title: 'كرتون 24', unitPerPiece: 24),
    const Unit(id: 2, title: 'كرتون 12', unitPerPiece: 12),
    const Unit(id: 3, title: 'كرتون 20', unitPerPiece: 20),
    const Unit(id: 4, title: 'كرتون 40', unitPerPiece: 40),
  ];

  void addUnit(String title, int unitPerPiece) {
    list.add(
      Unit(
        id: Random().nextInt(200) + 4,
        title: title,
        unitPerPiece: unitPerPiece,
      ),
    );
  }
}
