import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';
import 'package:store_warehouse/shared/function/dialog/delete_confirm.dart';
import 'package:store_warehouse/shared/function/dialog/edit_transaction_dialog.dart';
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
    final product =
        context.read<ProductViewModel>().getProductById(transaction.productId);
    final TransactionTypeModel transactionType = context
        .read<TransactionTypeViewModel>()
        .getTransactionById(transaction.transactionTypeId);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          context
              .read<TransactionViewModel>()
              .deleteTransaction(transaction.transactionId);
        },
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            final bool shouldDelete = await deleteConfirmDialog(context);
            return shouldDelete;
          } else {
            await editTransactionDialog(context, transaction);
            return false;
          }
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 16),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        secondaryBackground: Container(
          color: Colors.blue,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16),
          child: const Icon(Icons.edit, color: Colors.white),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 200, 200, 200),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(
                    File(product.imagePath),
                  ),
                ),
                title: Text(
                  product.title,
                  textAlign: TextAlign.start,
                ),
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
                      Container(
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppDesign.circularRadius),
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
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: transaction.transactionTypeId == 2
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ),
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
                  child: FittedBox(
                    child: Row(
                      children: [
                        const Text('ملاحظة: '),
                        Text(transaction.notes),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 16.0,
                  bottom: 2.0,
                ),
                child: Text(
                  '${transaction.createdAt.toString().substring(0, 10)} | ${TimeOfDay.fromDateTime(transaction.createdAt).format(context)}',
                  style: const TextStyle(fontSize: 12.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
