import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/transactions/controller/transaction_controller.dart';
import 'package:store_warehouse/transactions/model/transaction.dart';
import 'package:store_warehouse/transactions/view/widgets/transactions_widget.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  TransactionsScreenState createState() => TransactionsScreenState();
}

class TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    //! Build
    log('build: transaction screen has been built');
    return FutureBuilder<Map<String, List<Transaction>>>(
      future: Provider.of<TransactionController>(context).getFilteredList(),
      builder: (context, snapshot) {
        //! Build
        log('build: future in transaction screen has been built');
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: ListView(
                children: [
                  Column(
                    children: [
                      for (var i in snapshot.data!.keys)
                        testOnly(snapshot.data![i]!, i),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/no_transactions.png',
                  width: 250,
                ),
                const Center(
                  child: Text('لا توجد عمليات بعد'),
                ),
              ],
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget testOnly(List<Transaction> map, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            )),
        for (var i in map)
          TransactionsWidget(
            transaction: i,
          ),
      ],
    );
  }
}
