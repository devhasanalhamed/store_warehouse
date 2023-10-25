import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/products/products_provider.dart';
import 'package:store_warehouse/transactions/transaction.model.dart';

class TransactionsWidget extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionsWidget({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(
          Provider.of<ProductsProvider>(context, listen: false)
              .products
              .firstWhere((element) => element.id == transaction.productId)
              .title,
        ),
        title: RichText(
          text: TextSpan(
            text: transaction.quantity.toString(),
            style: const TextStyle(color: Colors.black, fontFamily: 'Cairo'),
            children: const [
              TextSpan(
                text: 'حبة',
                style: TextStyle(color: Colors.black, fontFamily: 'Cairo'),
              ),
            ],
          ),
        ),
        trailing: Text(
          DateFormat('hh:mm | yyyy-MM-dd').format(transaction.date),
        ),
      ),
    );
  }
}
