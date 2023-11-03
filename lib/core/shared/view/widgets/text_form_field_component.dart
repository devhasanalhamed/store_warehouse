import 'package:flutter/material.dart';

class TextFormFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final ValueChanged<String> onSubmit;
  final FormFieldValidator<String> validator;
  final String label;
  final int maxLines;
  final IconButton? prefixIcon;
  final Icon? suffixIcon;
  const TextFormFieldComponent({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.onSubmit,
    required this.validator,
    required this.label,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmit,
      validator: validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        label: Text(label),
        isDense: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      maxLines: maxLines,
    );
  }
}
