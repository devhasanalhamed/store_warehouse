import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store_warehouse/core/utils/sql_product.dart';
import 'package:store_warehouse/core/utils/sql_transaction.dart';
import 'package:store_warehouse/core/utils/sql_unit.dart';
import 'package:store_warehouse/transactions/model/transaction_model.dart';
import 'package:store_warehouse/core/mvc/models/unit.dart';
import 'package:store_warehouse/products/model/product_model.dart';

class TransactionController with ChangeNotifier {
  Future<Unit> getUnitById(int unitId) async {
    log('Function: getUnitById');
    final dbList = await SQLUnitHelper.getUnitById(unitId);
    final unit = dbList.map((e) => Unit.fromSQL(e)).toList();
    return unit.first;
  }

  Future<ProductModel> getProductById(int id) async {
    log('Function: getProductById');
    final dbList = await SQLProductHelper.getItemById(id);
    return dbList.map((e) => ProductModel.fromSQL(e)).first;
  }

  // Future<List<TransactionModel>> getTransactions() async {
  //   log('Function: getTransactions');
  //   final dbList = await SQLHelper.getTransactions();
  //   return dbList.map((e) => TransactionModel.fromSQL(e)).toList();
  // }

  Future<List<TransactionModel>> getTransactions() async {
    final dbList = await SQLTransactionHelper.productTransactionViewModel();
    log(dbList.toString());
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

  Future<void> addTransaction(
      int productId, int quantity, int type, String notes) async {
    log('Function: addTransaction');
    final product = await getProductById(productId);
    final productUnit = await getUnitById(product.unitId);
    final total = product.totalAmount;
    if (total >= quantity && type == 0) {
      SQLTransactionHelper.createTransaction(
        0,
        productId,
        quantity,
        notes,
      );
      final newTotal = total - quantity;
      final newTotalPerUnit = newTotal ~/ productUnit.unitPerPiece;
      log('$newTotalPerUnit');
      SQLProductHelper.updateQuantityOld(productId, newTotal, newTotalPerUnit);
    } else if (type == 1) {
      SQLTransactionHelper.createTransaction(
        1,
        productId,
        quantity,
        notes,
      );
      final newTotal = total + quantity;
      final newTotalPerUnit = newTotal ~/ productUnit.unitPerPiece;
      log('$newTotalPerUnit');
      SQLProductHelper.updateQuantityOld(productId, newTotal, newTotalPerUnit);
    }
    notifyListeners();
  }
}
