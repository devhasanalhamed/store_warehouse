import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';
import 'package:store_warehouse/transaction/logic/transaction_view_model.dart';
import 'package:store_warehouse/transaction/ui/widget/transaction_widget.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<TransactionViewModel, List<TransactionModel>>(
      selector: (_, provider) => provider.transactionList,
      builder: (_, transactionList, __) => ListView.builder(
        itemCount: transactionList.length,
        itemBuilder: (context, index) =>
            TransactionWidget(transaction: transactionList[index]),
      ),
    );
  }
}
