import 'package:flutter/material.dart';
import 'package:store_warehouse/core/mvc/models/transaction_product_view_model.dart';

class TransactionsWidget extends StatelessWidget {
  final ProductTransactionViewModel transaction;
  const TransactionsWidget({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              leading: SizedBox(
                width: 110,
                child: Text(transaction.productName),
              ),
              title: RichText(
                text: TextSpan(
                  text: transaction.quantity.toString(),
                  style:
                      const TextStyle(color: Colors.black, fontFamily: 'Cairo'),
                  children: const [
                    TextSpan(
                      text: ' حبة',
                      style:
                          TextStyle(color: Colors.black, fontFamily: 'Cairo'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 2,
            width: 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
