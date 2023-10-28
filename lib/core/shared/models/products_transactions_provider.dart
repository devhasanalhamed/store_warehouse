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

  // Future<void> deleteProduct(int productId) async {
  //   _products.removeWhere((element) => element.id == productId);
  //   notifyListeners();
  // }

  List<TransAction> getProductTransactions(int productId) {
    List<TransAction> temp = [];
    for (var element in _transactions) {
      if (element.productId == productId) {
        temp.add(element);
      }
    }

    return temp;
  }

  // Future<bool> updateTransaction(int productId, int subQuantity) async {
  //   final product = _products.firstWhere((element) => element.id == productId);
  //   if (product.totalAmount >= subQuantity) {
  //     final newTotal = product.totalAmount - subQuantity;
  //     _products.removeWhere((element) => element.id == productId);
  //     _products.add(
  //       Product(
  //         id: product.id,
  //         title: product.title,
  //         description: product.description,
  //         unitId: product.unitId,
  //         quantity: product.quantity,
  //         totalAmount: newTotal,
  //       ),
  //     );
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<Map<String, List<TransAction>>> getFilteredList() async {
    final transactions = await getTransactions();
    Map<String, List<TransAction>> temp = {};
    for (var item in transactions) {
      var x = item.createdAt;
      final trans = temp['mark'] ?? [];
      print(trans.toString());
      print(trans.length);
      var mark = '${x.month}|${x.day}|${x.year}';
      temp.addAll({
        mark: [...trans, item],
      });
      log(temp.toString());
    }
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
    // final product = _products.firstWhere((element) => element.id == productId);
    // if (product.totalAmount >= subQuantity) {
    //   log('is ok');
    //   final newTotal = product.totalAmount - subQuantity;
    //   log('$newTotal       ${product.totalAmount}   $subQuantity');
    //   _products.removeWhere((element) => element.id == productId);
    //   _products.add(
    //     Product(
    //       id: product.id,
    //       title: product.title,
    //       description: product.description,
    //       unitId: product.unitId,
    //       quantity: product.quantity,
    //       totalAmount: newTotal,
    //     ),
    //   );

    //   _transactions.add(
    //     TransAction(
    //       id: math.Random().nextInt(5000),
    //       quantity: subQuantity,
    //       productId: productId,
    //       createdAt: DateTime.now(),
    //     ),
    //   );
    // }

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
