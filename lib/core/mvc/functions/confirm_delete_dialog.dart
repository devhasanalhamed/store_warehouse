// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:store_warehouse/core/mvc/view/widgets/elevated_button_component.dart';
// import 'package:store_warehouse/products/controller/product_controller.dart';
// import 'package:store_warehouse/products/model/product_model.dart';

// Future<dynamic> confirmDeleteDialog(
//     BuildContext context, ProductModel product) {
//   return showDialog(
//     context: context,
//     builder: (context) => Directionality(
//       textDirection: TextDirection.rtl,
//       child: AlertDialog(
//         title: const Text('هل أنت متأكد؟'),
//         content: const Text('سيتم حذف جميع العمليات المتعلقة بالمنتج'),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         actions: [
//           ElevatedButtonComponent(
//               onPressed: () => Navigator.pop(context), title: 'إلغاء'),
//         ],
//       ),
//     ),
//   );
// }
