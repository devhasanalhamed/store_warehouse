import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/unit/logic/unit_view_model.dart';

class ShowUnitName extends StatelessWidget {
  final int unitId;
  const ShowUnitName({Key? key, required this.unitId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final unit = context.read<UnitViewModel>().getUnitById(unitId);
    return Text(
      unit.name,
      textAlign: TextAlign.center,
    );
  }
}
