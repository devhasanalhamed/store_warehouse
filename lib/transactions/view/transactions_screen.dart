import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/shared/models/products_transactions_provider.dart';
import 'package:store_warehouse/transactions/model/transaction.dart';
import 'package:store_warehouse/transactions/view/transactions_widget.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  TransactionsScreenState createState() => TransactionsScreenState();
}

class TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, List<TransAction>>>(
      future:
          Provider.of<ProductsTransactionsProvider>(context).getFilteredList(),
      builder: (context, snapshot) {
        log('the fuck');
        if (snapshot.hasData) {
          log(snapshot.data.toString());
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => testOnly(snapshot.data!),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget testOnly(Map<String, List<TransAction>> map) {
    log(map['10|28|2023']!.length.toString());
    print('testOnly');
    print(map.values.length);
    return Expanded(
      child: Column(
        children: [
          for (var i in map['10|28|2023']!)
            TransactionsWidget(
              transaction: i,
            ),
        ],
      ),
    );
  }
}
