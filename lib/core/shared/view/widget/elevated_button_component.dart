import 'package:flutter/material.dart';

class ElevatedButtonComponent extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const ElevatedButtonComponent({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('إضافة منتج جديد'),
    );
  }
}
