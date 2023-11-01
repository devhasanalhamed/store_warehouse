import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/shared/models/products_transactions_provider.dart';

import 'package:store_warehouse/core/shared/models/unit_provider.dart';
import 'package:store_warehouse/core/shared/view/widget/drop_from_field_component.dart';
import 'package:store_warehouse/core/shared/view/widget/elevated_button_component.dart';
import 'package:store_warehouse/core/shared/view/widget/text_form_field_component.dart';
import 'package:store_warehouse/products/controller/product_controller.dart';
import 'package:store_warehouse/products/view/widget/product_image_picker.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int? unitController;

    void validate() {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        log('Product information is valid, calling provider...');
        Provider.of<ProductsTransactionsProvider>(context, listen: false)
            .addProduct(
              titleController.text,
              descriptionController.text,
              Provider.of<ProductController>(context, listen: false)
                  .imagePicker!
                  .path,
              unitController!,
              int.parse(quantityController.text),
            )
            .then((value) => Navigator.pop(context));
      } else {
        log('not valid');
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
                      builder: (context, value, child) => ProductImagePicker(
                        onTap: value.pickImage,
                        photo: value.imagePicker,
                      ),
                    ),
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
                    Consumer<UnitProvider>(
                      builder: (context, value, child) =>
                          DropDownButtonFormFieldComponent(
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
                          for (var unit in value.list)
                            DropdownMenuItem(
                              value: unit.id,
                              alignment: Alignment.centerRight,
                              child: Text(unit.title),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => addUnit(context),
                            child: const Text('إضافة وحدة جديدة'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
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
                            child: const Text('إضافة منتج جديد'),
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

  addUnit(BuildContext context) {
    String unitTitle = '';
    int unitPerPiece = 0;
    showDialog(
      context: context,
      builder: (s) => Dialog(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: 350,
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'أسم الوحدة',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                  ),
                  onChanged: (value) => unitTitle = value,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'العدد بالحبة',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                  ),
                  onChanged: (value) => unitPerPiece = int.parse(value),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Provider.of<UnitProvider>(context, listen: false)
                          .addUnit(unitTitle, unitPerPiece)
                          .then(
                            (value) => {Navigator.of(context).pop()},
                          ),
                  child: const Text('إضافة وحدة جديد'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
