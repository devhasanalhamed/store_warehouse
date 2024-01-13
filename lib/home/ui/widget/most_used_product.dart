import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store_warehouse/core/constants/app_design.dart';

Widget mostUsedProduct(Map<String, dynamic> map) {
  return Stack(
    alignment: Alignment.center,
    children: [
      if (File(
        map['image_path'],
      ).existsSync())
        Image.file(
          File(
            map['image_path'],
          ),
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      FittedBox(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(AppDesign.smallPadding),
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    AppDesign.circularRadius,
                  ),
                ),
              ),
              color: Colors.white54,
            ),
            child: Text(
              map['name'],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
