import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';
import 'package:store_warehouse/product/data/product_model.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';
import 'package:store_warehouse/shared/widget/text_form_field_component.dart';
import 'package:store_warehouse/unit/ui/widget/select_unit_component.dart';

editProduct(BuildContext context, ProductModel product) {
  final GlobalKey<FormState> formKey = GlobalKey();
  String title = product.title;
  String description = product.description;
  String notes = product.notes;
  int unitId = product.unitId;
  return showModalBottomSheet(
    context: context,
    builder: (context) => Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDesign.mediumPadding,
        ),
        child: ListView(
          children: [
            const SizedBox(height: 32.0),
            TextFormFieldComponent(
              initialValue: title,
              labelText: 'اسم المنتج',
              onSaved: (newValue) => title = newValue!,
            ),
            const SizedBox(height: 16.0),
            TextFormFieldComponent(
              initialValue: description,
              labelText: 'الوصف',
              onSaved: (newValue) => description = newValue!,
            ),
            const SizedBox(height: 16.0),
            TextFormFieldComponent(
              initialValue: notes,
              labelText: 'الملاحظات',
              onSaved: (newValue) => notes = newValue!,
            ),
            const SizedBox(height: 16.0),
            SelectUnitComponent(
              initial: unitId,
              onChanged: (value) => unitId = value,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  context
                      .read<ProductViewModel>()
                      .updateProduct(
                        ProductModel(
                          id: product.id,
                          title: title,
                          imagePath: product.imagePath,
                          description: description,
                          unitId: unitId,
                          notes: notes,
                        ),
                      )
                      .then((value) => Navigator.pop(context));
                }
              },
              child: const Text('تعديل'),
            ),
          ],
        ),
      ),
    ),
  );
}
