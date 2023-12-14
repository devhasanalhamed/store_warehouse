import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/shared/widget/drop_down_button_form_field_component.dart';
import 'package:store_warehouse/unit/data/unit_model.dart';
import 'package:store_warehouse/unit/logic/unit_view_model.dart';

class SelectUnitComponent extends StatelessWidget {
  final int? initial;
  final ValueChanged onChanged;
  const SelectUnitComponent({
    Key? key,
    required this.onChanged,
    this.initial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<UnitViewModel, List<UnitModel>>(
      selector: (_, provider) => provider.unitList,
      builder: (_, unitList, __) => DropDownButtonFormFieldComponent(
        initial: initial,
        hint: const Text('اختر وحدة القياس '),
        items: [
          for (int i = 0; i < unitList.length; i++)
            DropdownMenuItem(
              value: unitList[i].id,
              alignment: Alignment.center,
              child: Text(unitList[i].name),
            )
        ],
        onChanged: onChanged,
        validator: (value) {
          if (value == null) {
            return 'wrong';
          }
          return null;
        },
      ),
    );
  }
}
