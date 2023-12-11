// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:store_warehouse/core/mvc/view/widgets/elevated_button_component.dart';
// import 'package:store_warehouse/core/mvc/view/widgets/text_form_field_component.dart';
// import 'package:store_warehouse/products/model/product_model.dart';
// import 'package:store_warehouse/transactions/controller/transaction_controller.dart';

// addQuantityModalBottomSheet(BuildContext context, ProductModel product) {
//   int quantity = 0;
//   final GlobalKey<FormState> formKey = GlobalKey();
//   showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(25),
//         topRight: Radius.circular(25),
//       ),
//     ),
//     builder: (BuildContext context) => Directionality(
//       textDirection: TextDirection.rtl,
//       child: Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         child: Container(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 8.0,
//             vertical: 16.0,
//           ),
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(25),
//               topRight: Radius.circular(25),
//             ),
//           ),
//           height: MediaQuery.of(context).size.height / 2,
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text('إضافة كمية جديدة'),
//                 const SizedBox(height: 16.0),
//                 TextFormFieldComponent(
//                   label: 'أسم المنتج',
//                   initialValue: product.title,
//                   readOnly: true,
//                 ),
//                 const SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormFieldComponent(
//                         label: 'نوع الوحدة',
//                         initialValue: product.unitTitle,
//                         readOnly: true,
//                       ),
//                     ),
//                     const SizedBox(width: 8.0),
//                     Expanded(
//                       child: TextFormFieldComponent(
//                         label: 'الكمية الحالية',
//                         initialValue: '${product.totalAmount}',
//                         readOnly: true,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     const Text(
//                       'الكمية',
//                     ),
//                     const SizedBox(width: 12.0),
//                     Expanded(
//                       child: TextFormFieldComponent(
//                         label: 'أضف الكمية بالحبة',
//                         keyboardType: TextInputType.number,
//                         onChanged: (value) => quantity = int.parse(value),
//                         validator: (value) {
//                           if (value!.isEmpty || value == '0') {
//                             return 'الرجاء إضافة كمية صحيحة';
//                           }
//                           return null;
//                         },
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                           LengthLimitingTextInputFormatter(16)
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16.0),
//                 ElevatedButtonComponent(
//                   title: 'إضافة كمية جديدة',
//                   onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                       // provider
//                       //     .updateAddQuantity(product.id, quantity)
//                       //     .then((value) => Navigator.pop(context));
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
