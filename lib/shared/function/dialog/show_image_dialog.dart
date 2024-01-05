import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/constants/app_design.dart';
import 'package:store_warehouse/product/data/product_model.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';

showImageDialog(BuildContext context, ProductModel product) => showDialog(
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
                  width: double.infinity,
                  height: 400,
                  child: Image.file(
                    File(product.imagePath),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Text('خطأ'),
                  ),
                ),
                const SizedBox(height: AppDesign.mediumPadding),
                ElevatedButton(
                  onPressed: () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (pickedFile == null) return;
                    final pickedImage = File(pickedFile.path);
                    final appDocumentPath =
                        await getApplicationDocumentsDirectory();
                    final fileName = path.basename(pickedImage.path);
                    final newPath = '${appDocumentPath.path}/$fileName';
                    final result = await pickedImage.copy(newPath);
                    print(result.path);
                    OpenFile.open(result.path);

                    context
                        .read<ProductViewModel>()
                        .updateProduct(
                          ProductModel(
                            id: product.id,
                            title: product.title,
                            imagePath: result.path,
                            description: product.description,
                            unitId: product.unitId,
                            notes: product.notes,
                          ),
                        )
                        .then(
                          (value) => Navigator.pop(context),
                        );
                  },
                  child: const Text('تعديل الصورة'),
                )
              ],
            ),
          ),
        ));
