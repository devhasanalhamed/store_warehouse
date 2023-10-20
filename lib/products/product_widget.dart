import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/shared/unit_provider.dart';
import 'package:store_warehouse/transactions/data/model/product_model.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;
  const ProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: Text(product.title),
              subtitle: Text(product.category),
              trailing: const Icon(Icons.delete),
            ),
            Table(
              children: [
                const TableRow(
                  children: [
                    Text(
                      'نوع الوحدة',
                    ),
                    Text(
                      'الكمية بالوحدة',
                    ),
                    Text(
                      'الكمية بالحبة',
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      Provider.of<UnitProvider>(context, listen: false)
                          .list
                          .firstWhere((element) => element.id == product.unitId)
                          .title,
                    ),
                    Text(
                      product.quantity.toString(),
                    ),
                    Text(
                      (product.quantity *
                              Provider.of<UnitProvider>(context, listen: false)
                                  .list
                                  .firstWhere(
                                      (element) => element.id == product.unitId)
                                  .unitPerPiece)
                          .toString(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
