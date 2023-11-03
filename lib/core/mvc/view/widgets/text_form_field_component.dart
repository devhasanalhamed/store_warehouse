import 'package:flutter/material.dart';

class TextFormFieldComponent extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onSubmit;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String> validator;
  final String label;
  final int maxLines;
  final int? maxLength;
  final IconButton? prefixIcon;
  final Icon? suffixIcon;
  const TextFormFieldComponent({
    Key? key,
    this.controller,
    required this.keyboardType,
    this.onSubmit,
    required this.validator,
    required this.label,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validator,
      maxLength: maxLength,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
        label: Text(label),
        isDense: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      maxLines: maxLines,
    );
  }
}
