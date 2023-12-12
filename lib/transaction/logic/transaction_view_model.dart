import 'package:flutter/material.dart';
import 'package:store_warehouse/core/database/dao/transaction_dao.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';

class TransactionViewModel extends ChangeNotifier {
  List<TransactionModel> transactionList = [];
  Future<void> addTransaction(TransactionModel transaction) async {
    await TransactionDAO().insert(transaction);
  }

  Future<void> getTransactions() async {
    final result = await TransactionDAO().fetch();
    transactionList = result;
    notifyListeners();
  }
}
