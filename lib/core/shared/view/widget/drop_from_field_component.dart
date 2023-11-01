import 'package:flutter/material.dart';

class DropDownButtonFormFieldComponent extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem> dropList;
  final ValueChanged<dynamic> onChanged;
  const DropDownButtonFormFieldComponent({
    Key? key,
    required this.label,
    required this.dropList,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: null,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        label: Text(label),
        isDense: true,
      ),
      padding: EdgeInsets.zero,
      items: dropList,
      onChanged: onChanged,
    );
  }
}
