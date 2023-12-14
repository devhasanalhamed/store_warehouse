import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/product/ui/widget/show_product.component.dart';
import 'package:store_warehouse/shared/widget/text_form_field_component.dart';
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
    Future<bool> showDeleteConfirmationDialog() async {
      return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete Item"),
            content: Text("Are you sure you want to delete this item?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Delete"),
              ),
            ],
          );
        },
      );
    }

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
          if (direction == DismissDirection.endToStart) {
            // Edit
            // Implement your edit logic here
          } else if (direction == DismissDirection.startToEnd) {
            // Delete
            // Implement your delete logic here
          }
        },
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            // Edit
            // Implement your edit confirmation logic here
            final bool shouldDelete = await showDeleteConfirmationDialog();
            return shouldDelete;
          } else if (direction == DismissDirection.endToStart) {
            // Delete
            // Implement your delete confirmation logic here
            await showDialog(
              context: context,
              builder: (context) {
                int amount = transaction.amount;
                String notes = transaction.notes;
                return Dialog(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormFieldComponent(
                          initialValue: transaction.amount.toString(),
                          keyboardType: TextInputType.number,
                          labelText: 'الكمية',
                          onChanged: (value) => amount = int.parse(value),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormFieldComponent(
                          initialValue: transaction.notes,
                          keyboardType: TextInputType.number,
                          labelText: 'الملاحظات',
                          onChanged: (value) => notes = value,
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => context
                                  .read<TransactionViewModel>()
                                  .updateTransaction(TransactionModel(
                                    transactionId: transaction.transactionId,
                                    productId: transaction.productId,
                                    transactionTypeId:
                                        transaction.transactionTypeId,
                                    amount: amount,
                                    notes: notes,
                                    createdAt: DateTime.now(),
                                  ))
                                  .then((value) => Navigator.pop(context)),
                              child: const Text('تعديل'),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('data'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
            return false;
          }
          return false;
        },
        background: Container(
          color: Colors.red,
          child: Icon(Icons.delete, color: Colors.white),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 16),
        ),
        secondaryBackground: Container(
          color: Colors.blue,
          child: Icon(Icons.edit, color: Colors.white),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 16),
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
