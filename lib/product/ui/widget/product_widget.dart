import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store_warehouse/product/data/product_model.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;
  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
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
                                File(''),
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
                      image: FileImage(File('')),
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
              subtitle: Text('product.description'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: const Color.fromARGB(255, 235, 102, 92),
                onPressed: () {},
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
                    Text(
                      'product.unitTitle',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      6.toString(),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      (567).toString(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Text('ملاحظة: '),
                  Text('product.notes'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: () {},
                    label: const Text('كمية جديدة'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const Column(
                          children: [
                            Text('soon'),
                          ],
                        ),
                      );
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
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.green,
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.green, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    icon: const Icon(Icons.edit),
                    label: const Text('تعديل'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const Column(
                          children: [
                            Text('soon'),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.history),
                    label: const Text('العمليات'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
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
