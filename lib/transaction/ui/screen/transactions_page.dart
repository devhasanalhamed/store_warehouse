import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';
import 'package:store_warehouse/transaction/logic/transaction_view_model.dart';
import 'package:store_warehouse/transaction/ui/screen/all_transactions_screen.dart';
import 'package:store_warehouse/transaction/ui/widget/transaction_widget.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<TransactionViewModel, List<TransactionModel>>(
      selector: (_, provider) => provider.transactionList,
      builder: (_, transactionList, __) => ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDesign.smallPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'العمليات الأخيرة',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(width: 4.0),
                Icon(
                  Icons.timeline,
                  size: 24.0,
                  color: Theme.of(context).colorScheme.primary,
                )
              ],
            ),
          ),
          Column(
            children: [
              for (int index = 0;
                  index < min(transactionList.length, 10);
                  index++)
                TransactionWidget(transaction: transactionList[index]),
            ],
          ),
          if (transactionList.length >= 10)
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AllTransactionsScreen.routeName),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('عرض كل العمليات'),
                  SizedBox(width: 4.0),
                  Icon(Icons.access_time),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
