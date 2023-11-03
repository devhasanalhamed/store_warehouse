import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_warehouse/core/shared/models/products_transactions_provider.dart';
import 'package:store_warehouse/core/shared/models/unit.dart';
import 'package:store_warehouse/products/controller/product_controller.dart';
import 'package:store_warehouse/products/model/product.dart';
import 'package:store_warehouse/transactions/controller/transaction_controller.dart';
import 'package:store_warehouse/transactions/model/transaction.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File imagePath = File(product.imagePath);
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ListTile(
              leading: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                imagePath,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Text('خطأ'),
                              ),
                            ),
                          ));
                },
                child: Container(
                  width: 56,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: FileImage(imagePath),
                      onError: (exception, stackTrace) => const Center(
                        child: Text(
                          'خطأ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              title: Text(product.title),
              subtitle: Text(product.description),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: const Color.fromARGB(255, 235, 102, 92),
                onPressed: () {
                  Provider.of<ProductController>(context, listen: false)
                      .deleteProduct(product);
                },
              ),
            ),
            Table(
              border: const TableBorder(
                horizontalInside: BorderSide(color: Colors.grey, width: 1),
                verticalInside: BorderSide(color: Colors.grey, width: 1),
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
              children: [
                const TableRow(
                  children: [
                    Text(
                      'نوع الوحدة',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'الكمية بالوحدة',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'الكمية بالحبة',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    FutureBuilder<Unit>(
                      future:
                          Provider.of<ProductController>(context, listen: false)
                              .getUnitById(product.unitId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.title,
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return const Text(
                            'يتم جلب الوحدة',
                            textAlign: TextAlign.center,
                          );
                        }
                      },
                    ),
                    Text(
                      product.quantity.toString(),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      (product.totalAmount).toString(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            FutureBuilder<List<TransAction>>(
              future: Provider.of<TransactionController>(context)
                  .getProductTransactions(product.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      for (TransAction i in snapshot.data!)
                        Text(
                          i.quantity.toString(),
                        ),
                    ],
                  );
                }
                return const Text('العمليات الحديثة');
              },
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      int quantity = 0;
                      final value = Provider.of<ProductController>(context,
                          listen: false);
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            width: 350,
                            height: 350,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 16.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'نوع الوحدة',
                                    ),
                                    const SizedBox(width: 12.0),
                                    Expanded(
                                      child: DropdownButtonFormField(
                                        value: null,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          hintText: product.unitId.toString(),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                            vertical: 4.0,
                                          ),
                                        ),
                                        padding: EdgeInsets.zero,
                                        items: const [],
                                        onChanged: null,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'الكمية',
                                    ),
                                    const SizedBox(width: 12.0),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'أدخل الكمية بالحبة',
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                            vertical: 4.0,
                                          ),
                                        ),
                                        onChanged: (value) =>
                                            quantity = int.parse(value),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () => value
                                      .updateAddQuantity(product.id, quantity)
                                      .then((value) => Navigator.pop(context)),
                                  child: const Text(
                                    'إضافة كمية جديدة',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    label: const Text('كمية جديدة'),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      // String title = product.title;
                      // String description = product.description;
                      // int unitId = product.unitId;
                      // final provider =
                      //     Provider.of<ProductsTransactionsProvider>(context,
                      //         listen: false);
                      // final unitList =
                      //     Provider.of<UnitProvider>(context, listen: false)
                      //         .list;
                      // log(unitList.length.toString());
                      // showModalBottomSheet(
                      //   context: context,
                      //   builder: (context) => Directionality(
                      //     textDirection: TextDirection.rtl,
                      //     child: Container(
                      //       width: 350,
                      //       height: 350,
                      //       padding: const EdgeInsets.symmetric(
                      //         horizontal: 8.0,
                      //         vertical: 16.0,
                      //       ),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           TextFormField(
                      //             initialValue: product.title,
                      //             decoration: const InputDecoration(
                      //               border: OutlineInputBorder(),
                      //               contentPadding: EdgeInsets.symmetric(
                      //                 horizontal: 8.0,
                      //                 vertical: 4.0,
                      //               ),
                      //             ),
                      //             onChanged: (value) => title = value,
                      //           ),
                      //           TextFormField(
                      //             initialValue: product.description,
                      //             decoration: const InputDecoration(
                      //               border: OutlineInputBorder(),
                      //               contentPadding: EdgeInsets.symmetric(
                      //                 horizontal: 8.0,
                      //                 vertical: 4.0,
                      //               ),
                      //             ),
                      //             onChanged: (value) => description = value,
                      //           ),
                      //           Row(
                      //             children: [
                      //               const Text(
                      //                 'نوع الوحدة',
                      //               ),
                      //               const SizedBox(width: 12.0),
                      //               Expanded(
                      //                 child: DropdownButtonFormField(
                      //                   value: product.unitId,
                      //                   decoration: const InputDecoration(
                      //                     border: OutlineInputBorder(),
                      //                     contentPadding: EdgeInsets.symmetric(
                      //                       horizontal: 8.0,
                      //                       vertical: 4.0,
                      //                     ),
                      //                   ),
                      //                   padding: EdgeInsets.zero,
                      //                   items: [
                      //                     for (var item in unitList)
                      //                       DropdownMenuItem(
                      //                         value: item.id,
                      //                         alignment: Alignment.centerRight,
                      //                         child: Text(item.title),
                      //                       ),
                      //                   ],
                      //                   onChanged: (value) => unitId = value!,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //           const Text(
                      //             'سيتم تعديل المعلومات على جميع العمليات السابقة',
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           ElevatedButton(
                      //             onPressed: () => provider
                      //                 .editProduct(
                      //                   product.id,
                      //                   title,
                      //                   description,
                      //                   unitId,
                      //                 )
                      //                 .then((value) => Navigator.pop(context)),
                      //             child: const Text(
                      //               'تعديل معلومات المنتج',
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // );
                    },
                    style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.green),
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    icon: const Icon(Icons.edit),
                    label: const Text('تعديل'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
