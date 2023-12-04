import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store_warehouse/transactions/model/transaction_model.dart';

class TransactionsWidget extends StatelessWidget {
  final TransactionModel transaction;
  final String unitTitle;
  const TransactionsWidget(
      {Key? key, required this.transaction, required this.unitTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Dismissible(
        key: UniqueKey(),
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
                    File(transaction.productImagePath),
                  ),
                ),
                title: Text(transaction.productName),
                subtitle: Text(
                    '${transaction.createdAt.toString().substring(0, 10)} | ${TimeOfDay.fromDateTime(transaction.createdAt).format(context)}'),
                trailing: SizedBox(
                  width: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'عملية ${(transaction.transactionTypeId == 0 ? 'سحب' : 'اضافة')}',
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
                                  color: transaction.transactionTypeId == 0
                                      ? Colors.red
                                      : Colors.green,
                                )),
                            child: Center(
                              child: Text(
                                '${transaction.quantity}',
                                style: TextStyle(
                                  color: transaction.transactionTypeId == 0
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            unitTitle,
                            style: TextStyle(
                              color: transaction.transactionTypeId == 0
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
              if (transaction.notes.isNotEmpty)
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
