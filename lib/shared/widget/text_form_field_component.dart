import 'package:flutter/material.dart';
import 'package:store_warehouse/core/utils/app_design.dart';

class TextFormFieldComponent extends StatelessWidget {
  final String? labelText;
  final String? initialValue;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  const TextFormFieldComponent({
    Key? key,
    this.labelText,
    this.onSaved,
    this.validator,
    this.keyboardType,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDesign.circularRadius),
        ),
        contentPadding: const EdgeInsets.all(AppDesign.largePadding),
      ),
      onSaved: onSaved,
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
