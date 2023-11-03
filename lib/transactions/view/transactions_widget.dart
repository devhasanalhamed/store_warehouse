import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/products/controller/product_controller.dart';
import 'package:store_warehouse/products/model/product.dart';
import 'package:store_warehouse/transactions/model/transaction.dart';

class TransactionsWidget extends StatelessWidget {
  final TransAction transaction;
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
                child: Consumer<ProductController>(
                  builder: (context, value, child) =>
                      FutureBuilder<List<Product>>(
                    future: value.getProduct(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!
                              .firstWhere((element) =>
                                  element.id == transaction.productId)
                              .title,
                          overflow: TextOverflow.clip,
                        );
                      } else {
                        return const Text('');
                      }
                    },
                  ),
                ),
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
              trailing: Text(
                DateFormat('hh:mm | yyyy-MM-dd').format(transaction.createdAt),
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
