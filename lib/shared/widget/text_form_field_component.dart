import 'package:flutter/material.dart';
import 'package:store_warehouse/core/utils/app_design.dart';

class TextFormFieldComponent extends StatelessWidget {
  final String? hintText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  const TextFormFieldComponent({
    Key? key,
    this.hintText,
    this.onSaved,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
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
