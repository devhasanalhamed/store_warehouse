import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/product/data/product_model.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة منتج'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: context.read<ProductViewModel>().formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'عنوان',
                  border: OutlineInputBorder(),
                ),
                onSaved: (newValue) =>
                    context.read<ProductViewModel>().title = newValue!,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  }
                  return 'f';
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'وصف',
                  border: OutlineInputBorder(),
                ),
                onSaved: (newValue) =>
                    context.read<ProductViewModel>().description = newValue!,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  }
                  return 'f';
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'الملاحظات',
                  border: OutlineInputBorder(),
                ),
                onSaved: (newValue) =>
                    context.read<ProductViewModel>().notes = newValue!,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  }
                  return 'f';
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'عنوان الصورة',
                  border: OutlineInputBorder(),
                ),
                onSaved: (newValue) =>
                    context.read<ProductViewModel>().imagePath = newValue!,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  }
                  return 'f';
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'الوحدة',
                  border: OutlineInputBorder(),
                ),
                onSaved: (newValue) =>
                    context.read<ProductViewModel>().unitId = newValue!,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  }
                  return 'f';
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (true) {
                    print('valid');

                    context.read<ProductViewModel>().x();
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
