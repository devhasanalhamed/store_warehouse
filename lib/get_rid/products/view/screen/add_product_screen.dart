// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:store_warehouse/get_rid/products/controller/product_controller.dart';
// import 'package:store_warehouse/get_rid/products/view/widget/product_image_picker.dart';

// class AddProductScreen extends StatelessWidget {
//   AddProductScreen({Key? key}) : super(key: key);
//   final GlobalKey<FormState> formKey = GlobalKey();
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     int? unitController;

//     void validate() {
//       final isValid = formKey.currentState!.validate();
//       if (isValid) {
//         log('Product information is valid, calling provider...');
//       } else {
//         log('not valid product information');
//       }
//     }

//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('إضافة منتج'),
//           centerTitle: true,
//         ),
//         body: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 8.0,
//                 vertical: 16.0,
//               ),
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 16.0),
//                     TextFormFieldComponent(
//                       controller: titleController,
//                       label: 'عنوان المنتج',
//                       keyboardType: TextInputType.text,
//                       onSubmit: (value) => {},
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'الرجاء اختيار عنوان';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16.0),
//                     TextFormFieldComponent(
//                       controller: descriptionController,
//                       label: 'وصف المنتج',
//                       keyboardType: TextInputType.text,
//                       onSubmit: (value) => {},
//                       validator: (value) {
//                         return null;
//                       },
//                       maxLines: 2,
//                     ),
//                     const SizedBox(height: 16.0),
//                     const SizedBox(height: 4.0),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextButton(
//                             onPressed: () => addUnitDialog(context),
//                             child: const Text(
//                               'إضافة وحدة جديدة',
//                               style: TextStyle(
//                                 decoration: TextDecoration.underline,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 4.0),
//                     TextFormFieldComponent(
//                       controller: quantityController,
//                       keyboardType: TextInputType.number,
//                       onSubmit: (value) {},
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'الرجاء إدخال الكمية';
//                         }
//                         return null;
//                       },
//                       label: 'الكمية بالوحدة',
//                     ),
//                     const SizedBox(height: 16.0),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButtonComponent(
//                             onPressed: () => validate(),
//                             title: 'إضافة منتج جديد',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
