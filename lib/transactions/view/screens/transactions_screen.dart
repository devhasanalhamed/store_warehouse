import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/transactions/model/transaction_model.dart';
import 'package:store_warehouse/transactions/controller/transaction_controller.dart';
import 'package:store_warehouse/transactions/view/screens/all_transactions_screen.dart';
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
    return Text('data');
  }
}
