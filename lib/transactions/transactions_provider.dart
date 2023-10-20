import 'dart:math';
import 'package:flutter/material.dart';
import 'package:store_warehouse/transactions/data/model/transaction.model.dart';

class TransactionsProvider extends ChangeNotifier {
  List<TransactionModel> transactions = [];

  Future<void> addTransaction(
      int productId, int quantity) async {
    transactions.add(TransactionModel(
      id: Random().nextInt(5000),
      quantity: quantity,
      productId: productId,
      date: DateTime.now(),
    ));
    notifyListeners();
  }
}
