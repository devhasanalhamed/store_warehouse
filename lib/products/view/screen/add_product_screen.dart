import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/mvc/controller/unit_provider.dart';
import 'package:store_warehouse/core/mvc/models/unit.dart';
import 'package:store_warehouse/core/mvc/view/widgets/drop_from_field_component.dart';
import 'package:store_warehouse/core/mvc/view/widgets/elevated_button_component.dart';
import 'package:store_warehouse/core/mvc/view/widgets/text_form_field_component.dart';
import 'package:store_warehouse/products/controller/product_controller.dart';
import 'package:store_warehouse/products/view/widget/product_image_picker.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int? unitController;
    final provider = Provider.of<ProductController>(context, listen: false);
    provider.removeCurrentImage();

    void validate() {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        log('Product information is valid, calling provider...');
        Provider.of<ProductController>(context, listen: false)
            .addProduct(
              titleController.text,
              descriptionController.text,
              unitController!,
              int.parse(quantityController.text),
              notesController.text,
            )
            .then((value) => Navigator.pop(context));
      } else {
        log('not valid product information');
      }
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إضافة منتج'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Consumer<ProductController>(
                        builder: (context, value, child) {
                      log('build: product consumer in add product screen has built');
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductImagePicker(
                            onTap: value.pickImage,
                            photo: value.imagePicker,
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 16.0),
                    TextFormFieldComponent(
                      controller: titleController,
                      label: 'عنوان المنتج',
                      keyboardType: TextInputType.text,
                      onSubmit: (value) => {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'الرجاء اختيار عنوان';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormFieldComponent(
                      controller: descriptionController,
                      label: 'وصف المنتج',
                      keyboardType: TextInputType.text,
                      onSubmit: (value) => {},
                      validator: (value) {
                        return null;
                      },
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormFieldComponent(
                      controller: notesController,
                      label: 'الملاحظات',
                      keyboardType: TextInputType.text,
                      onSubmit: (value) => {},
                    ),
                    const SizedBox(height: 16.0),
                    Consumer<UnitProvider>(builder: (context, value, child) {
                      log('build: unit consumer in add product screen has built');
                      return FutureBuilder<List<Unit>>(
                          future: value.getUnits(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return DropDownButtonFormFieldComponent(
                                label: 'أختر نوع الوحدة',
                                onChanged: (value) =>
                                    unitController = int.parse('$value'),
                                validator: (value) {
                                  if (unitController == null) {
                                    return 'الرجاء اختيار الوحدة';
                                  }
                                  return null;
                                },
                                dropList: [
                                  for (var unit in snapshot.data!)
                                    DropdownMenuItem(
                                      value: unit.id,
                                      alignment: Alignment.centerRight,
                                      child: Text(unit.title),
                                    ),
                                ],
                              );
                            } else {
                              return DropDownButtonFormFieldComponent(
                                label: 'جاري جلب قائمة الوحدات...',
                                dropList: const [],
                                onChanged: (_) {},
                              );
                            }
                          });
                    }),
                    const SizedBox(height: 16.0),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: TextButton(
                    //         onPressed: () => addUnitDialog(context),
                    //         child: const Text(
                    //           'إضافة وحدة جديدة',
                    //           style: TextStyle(
                    //             decoration: TextDecoration.underline,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 4.0),
                    TextFormFieldComponent(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      onSubmit: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'الرجاء إدخال الكمية';
                        }
                        return null;
                      },
                      label: 'الكمية بالوحدة',
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButtonComponent(
                            onPressed: () => validate(),
                            title: 'إضافة منتج جديد',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
