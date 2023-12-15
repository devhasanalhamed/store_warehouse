import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/shared/widget/text_form_field_component.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';
import 'package:store_warehouse/transaction/logic/transaction_view_model.dart';

editTransactionDialog(BuildContext context, TransactionModel transaction) =>
    showDialog(
      context: context,
      builder: (context) {
        int amount = transaction.amount;
        String notes = transaction.notes;
        return Dialog(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
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
                            transactionTypeId: transaction.transactionTypeId,
                            amount: amount,
                            notes: notes,
                            createdAt: DateTime.now(),
                          ))
                          .then((value) => Navigator.pop(context)),
                      child: const Text('تعديل'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('الغاء'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
