import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';

showImageDialog(BuildContext context, String imagePath) => showDialog(
    context: context,
    builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDesign.circularRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.file(
                    File(imagePath),
                    errorBuilder: (context, error, stackTrace) =>
                        const Text('خطأ'),
                  ),
                ),
                const SizedBox(height: AppDesign.largePadding),
                ElevatedButton(
                  onPressed: () async {
                    final result = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (result == null) {
                      return;
                    }
                  },
                  child: const Text('تعديل الصورة'),
                )
              ],
            ),
          ),
        ));
