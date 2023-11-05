import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store_warehouse/transactions/model/transaction_model.dart';
import 'package:store_warehouse/core/mvc/models/unit.dart';
import 'package:store_warehouse/core/utils/sql_helper.dart';
import 'package:store_warehouse/products/model/product_model.dart';

class TransactionController with ChangeNotifier {
  Future<Unit> getUnitById(int unitId) async {
    log('Function: getUnitById');
    final dbList = await SQLHelper.getUnitById(unitId);
    final unit = dbList.map((e) => Unit.fromSQL(e)).toList();
    return unit.first;
  }

  Future<ProductModel> getProductById(int id) async {
    log('Function: getProductById');
    final dbList = await SQLHelper.getItemById(id);
    return dbList.map((e) => ProductModel.fromSQL(e)).first;
  }

  // Future<List<TransactionModel>> getTransactions() async {
  //   log('Function: getTransactions');
  //   final dbList = await SQLHelper.getTransactions();
  //   return dbList.map((e) => TransactionModel.fromSQL(e)).toList();
  // }

  Future<List<TransactionModel>> getTransactions() async {
    final dbList = await SQLHelper.productTransactionViewModel();
    return dbList.map((e) => TransactionModel.fromSQL(e)).toList();
  }

  Future<List<TransactionModel>> getProductTransactions(int productId) async {
    log('Function: getProductTransactions');
    List<TransactionModel> temp = await getTransactions();
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

  Future<Map<String, List<TransactionModel>>> getFilteredList() async {
    log('Function: getFilteredList');
    final transactions = await getTransactions();
    Map<String, List<TransactionModel>> temp = {};
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
