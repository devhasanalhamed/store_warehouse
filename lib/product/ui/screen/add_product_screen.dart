import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/product/data/product_model.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';
import 'package:store_warehouse/shared/widget/text_form_field_component.dart';
import 'package:store_warehouse/shared/widget/upload_image.dart';
import 'package:store_warehouse/unit/ui/widget/select_unit_component.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    late String title;
    late String description;
    late String notes;
    String? imagePath;
    late int unitId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة منتج'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16.0),
              UploadImage(
                onTakePhoto: (path) {
                  return imagePath = path!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormFieldComponent(
                hintText: 'عنوان',
                onSaved: (newValue) => title = newValue!,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  }
                  return 'f';
                },
              ),
              const SizedBox(height: 16.0),
              TextFormFieldComponent(
                hintText: 'وصف',
                onSaved: (newValue) => description = newValue!,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  }
                  return 'f';
                },
              ),
              const SizedBox(height: 16.0),
              TextFormFieldComponent(
                hintText: 'الملاحظات',
                onSaved: (newValue) => notes = newValue!,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  }
                  return 'f';
                },
              ),
              const SizedBox(height: 16.0),
              SelectUnitComponent(
                onChanged: (value) => unitId = value,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context
                        .read<ProductViewModel>()
                        .addProduct(
                          ProductModel(
                            id: 0,
                            title: title,
                            imagePath: imagePath ?? '',
                            description: description,
                            unitId: unitId,
                            notes: notes,
                          ),
                        )
                        .then((value) => Navigator.pop(context));
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
