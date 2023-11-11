import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldComponent extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onSubmit;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final String label;
  final int maxLines;
  final int? maxLength;
  final IconButton? prefixIcon;
  final Icon? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool readOnly;
  const TextFormFieldComponent({
    Key? key,
    this.controller,
    this.keyboardType,
    this.onSubmit,
    this.validator,
    required this.label,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.maxLength,
    this.inputFormatters,
    this.readOnly = false,
    this.initialValue,
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
      initialValue: initialValue,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
    );
  }
}
