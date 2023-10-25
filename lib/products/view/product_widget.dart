import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/shared/products_transactions_provider.dart';
import 'package:store_warehouse/core/shared/unit_provider.dart';
import 'package:store_warehouse/products/model/product.dart';
import 'package:store_warehouse/transactions/model/transaction.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<ProductsTransactionsProvider>(context)
        .getProductTransactions(product.id);
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
              subtitle: Text(product.description),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  Provider.of<ProductsTransactionsProvider>(context,
                          listen: false)
                      .deleteProduct(product.id);
                },
              ),
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
                      (product.totalAmount).toString(),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                for (TransAction i in transactions)
                  Text(
                    i.quantity.toString(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
