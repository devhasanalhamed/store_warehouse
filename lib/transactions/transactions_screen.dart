import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/transactions/transactions_provider.dart';
import 'package:store_warehouse/transactions/transactions_widget.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  TransactionsScreenState createState() => TransactionsScreenState();
}

class TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    final transaction = Provider.of<TransactionsProvider>(context).transactions;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (context, index) => TransactionsWidget(
              transaction: transaction[index],
            ),
          ),
        ),
      ],
    );
  }
}
