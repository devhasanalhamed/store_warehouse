import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/shared/models/products_transactions_provider.dart';
import 'package:store_warehouse/core/shared/models/unit_provider.dart';
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
                  // Provider.of<ProductsTransactionsProvider>(context,
                  //         listen: false)
                  //     .deleteProduct(product.id);
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
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    int quantity = 0;
                    final value = Provider.of<ProductsTransactionsProvider>(
                        context,
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
                                child: const Text('إضافة كمية جديدة'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  label: const Text('كمية جديدة'),
                ),
              ],
              
            ),
          ],
        ),
      ),
    );
  }
}
