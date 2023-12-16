import 'package:flutter/material.dart';
import 'package:store_warehouse/core/database/dao/transaction_dao.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';

class TransactionViewModel extends ChangeNotifier {
  List<TransactionModel> transactionList = [];
  Future<void> addTransaction(TransactionModel transaction) async {
    await TransactionDAO().insert(transaction);
    getTransactions();
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    await TransactionDAO().update(transaction);
    getTransactions();
  }

  Future<void> getTransactions() async {
    final result = await TransactionDAO().fetch();
    transactionList = result;
    notifyListeners();
  }

  Future<void> deleteTransaction(int id) async {
    await TransactionDAO().delete(id);
    getTransactions();
  }

  Future<int> getProductTransaction(int productId) async {
    final result = await TransactionDAO().calculateProductQuantity(productId);
    return result;
  }

  Future<List<TransactionModel>> getReport() async {
    final result = await TransactionDAO()
        .report(DateTime.now(), DateTime.now().subtract(Duration(days: 2)));
    print('report: $result');
    return result;
  }
}
