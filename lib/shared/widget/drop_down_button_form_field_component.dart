import 'package:flutter/material.dart';
import 'package:store_warehouse/core/utils/app_design.dart';

class DropDownButtonFormFieldComponent extends StatelessWidget {
  final List<DropdownMenuItem>? items;
  final ValueChanged? onChanged;
  final Widget? hint;
  final int? initial;
  final FormFieldValidator<dynamic>? validator;
  const DropDownButtonFormFieldComponent({
    Key? key,
    this.items,
    this.onChanged,
    this.hint,
    this.validator,
    this.initial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: initial,
      items: items,
      hint: hint,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDesign.circularRadius),
        ),
        contentPadding: const EdgeInsets.all(AppDesign.mediumPadding),
      ),
    );
  }
}
