import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/product/ui/widget/show_product.component.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';
import 'package:store_warehouse/transaction/logic/transaction_view_model.dart';
import 'package:store_warehouse/transaction_type/data/transaction_type_model.dart';
import 'package:store_warehouse/transaction_type/logic/transaction_type_view_model.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionWidget({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TransactionTypeModel transactionType = context
        .read<TransactionTypeViewModel>()
        .getTransactionById(transaction.transactionTypeId);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) => context
            .read<TransactionViewModel>()
            .deleteTransaction(transaction.transactionId),
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color.fromARGB(255, 235, 232, 232),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.delete,
                color: Colors.red,
              )
            ],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 200, 200, 200),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(
                    File('transaction.productImagePath'),
                  ),
                ),
                title: ShowProductName(productId: transaction.productId),
                subtitle: Text(
                    '${transaction.createdAt.toString().substring(0, 10)} | ${TimeOfDay.fromDateTime(transaction.createdAt).format(context)}'),
                trailing: SizedBox(
                  width: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'عملية ${(transactionType.name)}',
                        style:
                            const TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                border: Border.all(
                                  color: transaction.transactionTypeId == 2
                                      ? Colors.red
                                      : Colors.green,
                                )),
                            child: Center(
                              child: Text(
                                '${transaction.amount}',
                                style: TextStyle(
                                  color: transaction.transactionTypeId == 2
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            transaction.notes,
                            style: TextStyle(
                              color: transaction.transactionTypeId == 2
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (transaction.notes.trim().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 8.0,
                  ),
                  child: Row(
                    children: [
                      const Text('ملاحظة: '),
                      Text(transaction.notes),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
