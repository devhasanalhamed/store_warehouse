import 'dart:ui';

import 'package:flutter/material.dart';

class ProductImagePicker extends StatelessWidget {
  final GestureTapCallback? onTap;
  const ProductImagePicker({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/image.png',
            width: double.infinity,
            height: 150,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2.0,
              sigmaY: 2.0,
            ),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.4),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(
              Icons.camera,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}
