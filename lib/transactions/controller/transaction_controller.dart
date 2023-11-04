import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store_warehouse/core/mvc/models/transaction_product_view_model.dart';
import 'package:store_warehouse/core/mvc/models/unit.dart';
import 'package:store_warehouse/core/utils/sql_helper.dart';
import 'package:store_warehouse/products/model/product.dart';
import 'package:store_warehouse/transactions/model/transaction.dart';

class TransactionController with ChangeNotifier {
  Future<Unit> getUnitById(int unitId) async {
    log('Function: getUnitById');
    final dbList = await SQLHelper.getUnitById(unitId);
    final unit = dbList.map((e) => Unit.fromSQL(e)).toList();
    return unit.first;
  }

  Future<Product> getProductById(int id) async {
    log('Function: getProductById');
    final dbList = await SQLHelper.getItemById(id);
    return dbList.map((e) => Product.fromSQL(e)).first;
  }

  Future<List<Transaction>> getTransactions() async {
    log('Function: getTransactions');
    final dbList = await SQLHelper.getTransactions();
    return dbList.map((e) => Transaction.fromSQL(e)).toList();
  }

  Future<List<ProductTransactionViewModel>> geeeeeeet() async {
    final dbList = await SQLHelper.productTransactionViewModel();
    log(dbList.toString());
    return dbList.map((e) => ProductTransactionViewModel.fromSQL(e)).toList();
  }

  Future<List<Transaction>> getProductTransactions(int productId) async {
    log('Function: getProductTransactions');
    List<Transaction> temp = await getTransactions();
    return temp.where((element) => element.productId == productId).toList();
  }

  String dater(DateTime date) {
    final today = DateTime.now();
    final difference = today.difference(date).inDays;
    switch (difference) {
      case 0:
        return 'اليوم';
      case 1:
        return 'بالأمس';
      case 2:
        return 'قبل يومين';
      default:
        return 'قبل $difference أيام';
    }
  }

  Future<Map<String, List<Transaction>>> getFilteredList() async {
    log('Function: getFilteredList');
    final transactions = await getTransactions();
    Map<String, List<Transaction>> temp = {};
    final trans = [];
    for (var item in transactions) {
      var mark = dater(item.createdAt);

      temp.addAll({
        mark: [...trans, item],
      });
      trans.add(item);
    }
    return temp;
  }

  Future<void> addTransaction(int productId, int subQuantity) async {
    log('Function: addTransaction');
    final product = await getProductById(productId);
    final productUnit = await getUnitById(product.unitId);
    final total = product.totalAmount;
    if (total >= subQuantity) {
      SQLHelper.createTransaction(productId, subQuantity);
      final newTotal = total - subQuantity;
      final newTotalPerUnit = newTotal ~/ productUnit.unitPerPiece;
      log('$newTotalPerUnit');
      SQLHelper.updateSubQuantity(productId, newTotal, newTotalPerUnit);
    }
    notifyListeners();
  }
}
