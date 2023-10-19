import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/transactions/presentation/controller/transactions_provider.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  TransactionsScreenState createState() => TransactionsScreenState();
}

class TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<TransactionsProvider>(context).products;
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => Text(products[index].title),
    );
  }
}
