import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store_warehouse/core/mvc/models/transaction_product_view_model.dart';

class TransactionsWidget extends StatelessWidget {
  final ProductTransactionViewModel transaction;
  const TransactionsWidget({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        width: 200,
        height: 200,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            )
          ],
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 235, 232, 232),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(
                File(transaction.productImagePath),
              ),
            ),
            title: Text(transaction.productName),
            subtitle: Text(transaction.createdAt.toString().substring(0, 10)),
            trailing: Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.red,
                  )),
              child: Center(
                child: Text(
                  'حبة ${transaction.quantity}',
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
