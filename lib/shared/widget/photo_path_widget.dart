import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store_warehouse/core/constants/app_design.dart';

class PhotoPathWidget extends StatelessWidget {
  final String photoPath;
  const PhotoPathWidget({
    Key? key,
    required this.photoPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photo = File(photoPath);
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDesign.circularRadius),
      child: photo.existsSync()
          ? Image.file(
              photo,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )
          : const Text('no image'),
    );
  }
}
