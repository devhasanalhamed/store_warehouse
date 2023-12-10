// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:store_warehouse/core/mvc/view/widgets/drop_from_field_component.dart';
// import 'package:store_warehouse/core/mvc/view/widgets/elevated_button_component.dart';
// import 'package:store_warehouse/core/mvc/view/widgets/text_form_field_component.dart';
// import 'package:store_warehouse/products/controller/product_controller.dart';
// import 'package:store_warehouse/products/model/product_model.dart';
// import 'package:store_warehouse/transactions/controller/transaction_controller.dart';

// class AddTransactionScreen extends StatefulWidget {
//   const AddTransactionScreen({Key? key}) : super(key: key);

//   @override
//   State<AddTransactionScreen> createState() => _AddTransactionScreenState();
// }

// class _AddTransactionScreenState extends State<AddTransactionScreen> {
//   final GlobalKey<FormState> formKey = GlobalKey();
//   ProductModel? product;
//   int? quantity;
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('إضافة عملية'),
//           centerTitle: true,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 8.0,
//             vertical: 16.0,
//           ),
//           child: Form(
//             key: formKey,
//             child: ListView(
//               children: [],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   addTransaction() {
//     if (formKey.currentState!.validate()) {
//     } else {
//       log('adding transaction is not valid ');
//     }
//   }
// }
