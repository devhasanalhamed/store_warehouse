import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/constants/app_design.dart';
import 'package:store_warehouse/product/data/product_model.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';
import 'package:store_warehouse/shared/function/dialog/edit_product_dialog.dart';
import 'package:store_warehouse/shared/function/dialog/show_image_dialog.dart';
import 'package:store_warehouse/transaction/logic/transaction_view_model.dart';
import 'package:store_warehouse/unit/ui/widget/show_unit_name.dart';

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
                onTap: () => showImageDialog(context, product),
                child: Container(
                  width: 56,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: FileImage(File(product.imagePath)),
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
                onPressed: () =>
                    context.read<ProductViewModel>().deleteProduct(product.id),
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
                      'الكمية المتوفرة',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    ShowUnitName(
                      unitId: product.unitId,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder<int>(
                          future: context
                              .read<TransactionViewModel>()
                              .getProductTransaction(product.id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                '${snapshot.data}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return const Text('جاري الحساب');
                            }
                          },
                        ),
                        const SizedBox(width: AppDesign.smallPadding),
                        ShowUnitName(
                          unitId: product.unitId,
                        ),
                      ],
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
                  Text(product.notes),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => editProduct(context, product),
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
                    onPressed: () => editProduct(context, product),
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
