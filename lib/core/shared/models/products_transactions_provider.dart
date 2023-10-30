import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store_warehouse/core/shared/models/unit.dart';
import 'package:store_warehouse/core/utils/sql_helper.dart';
import 'package:store_warehouse/products/model/product.dart';
import 'package:store_warehouse/transactions/model/transaction.dart';

class ProductsTransactionsProvider extends ChangeNotifier {
  ProductsTransactionsProvider({
    required this.unitList,
  });

  final List<Unit> unitList;

  Future<List<Product>> getProduct() async {
    final dbList = await SQLHelper.getItems();
    return dbList.map((e) => Product.fromSQL(e)).toList();
  }

  final List<TransAction> _transactions = [];

  List<TransAction> get transactions {
    return [..._transactions];
  }

  Future<Product> getProductById(int id) async {
    final dbList = await SQLHelper.getItemById(id);
    return dbList.map((e) => Product.fromSQL(e)).first;
  }

  int getPiecePerUnit(int unitId) {
    return unitList.firstWhere((element) => element.id == unitId).unitPerPiece;
  }

  Future<void> addProduct(
      String title, String description, int unitId, int quantity) async {
    await SQLHelper.createItem(title, description, unitId, quantity,
        (quantity * getPiecePerUnit(unitId)));
    notifyListeners();
  }

  List<TransAction> getProductTransactions(int productId) {
    List<TransAction> temp = [];
    for (var element in _transactions) {
      if (element.productId == productId) {
        temp.add(element);
      }
    }

    return temp;
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

  Future<Map<String, List<TransAction>>> getFilteredList() async {
    final transactions = await getTransactions();
    Map<String, List<TransAction>> temp = {};
    final trans = [];
    for (var item in transactions) {
      var mark = dater(item.createdAt);

      temp.addAll({
        mark: [...trans, item],
      });
      trans.add(item);
    }
    log(temp.values.toString());
    return temp;
  }

  Future<void> addTransaction(int productId, int subQuantity) async {
    final product = await getProductById(productId);
    final total = product.totalAmount;
    if (total >= subQuantity) {
      SQLHelper.createTransaction(productId, subQuantity);
      final newTotal = total - subQuantity;
      SQLHelper.updateSubQuantity(productId, newTotal);
    }
    notifyListeners();
  }

  Future<void> updateAddQuantity(int productId, int addQuantity) async {
    final product = await getProductById(productId);
    final totalAmount = product.totalAmount + addQuantity;
    SQLHelper.updateSubQuantity(productId, totalAmount);
  }

  Future<List<TransAction>> getTransactions() async {
    final dbList = await SQLHelper.getTransactions();
    return dbList.map((e) => TransAction.fromSQL(e)).toList();
  }
}
