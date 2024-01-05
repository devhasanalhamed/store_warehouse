import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/constants/app_design.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';
import 'package:store_warehouse/transaction/logic/transaction_view_model.dart';
import 'package:store_warehouse/transaction/ui/widget/transaction_widget.dart';

class AllTransactionsScreen extends StatelessWidget {
  static const routeName = 'all-transactions-screen';
  const AllTransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('كل العمليات'),
        centerTitle: true,
      ),
      body: Selector<TransactionViewModel, List<TransactionModel>>(
        selector: (_, provider) => provider.transactionList,
        builder: (_, transactionList, __) => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDesign.smallPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'كل العمليات',
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
                for (int index = 0; index < transactionList.length; index++)
                  TransactionWidget(transaction: transactionList[index]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
