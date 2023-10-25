import 'dart:math' as math;
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:store_warehouse/core/shared/models/unit.dart';
import 'package:store_warehouse/products/model/product.dart';
import 'package:store_warehouse/transactions/model/transaction.dart';

class ProductsTransactionsProvider extends ChangeNotifier {
  ProductsTransactionsProvider({
    required this.unitList,
  });

  final List<Unit> unitList;

  final List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  final List<TransAction> _transactions = [];

  List<TransAction> get transactions {
    return [..._transactions];
  }

  int getPiecePerUnit(int unitId) {
    return unitList.firstWhere((element) => element.id == unitId).unitPerPiece;
  }

  Future<void> addProduct(
      String title, String description, int unitId, int quantity) async {
    _products.add(
      Product(
        id: math.Random().nextInt(5000),
        title: title,
        description: description,
        unitId: unitId,
        quantity: quantity,
        totalAmount: (quantity * getPiecePerUnit(unitId)),
      ),
    );
    notifyListeners();
  }

  Future<void> deleteProduct(int productId) async {
    _products.removeWhere((element) => element.id == productId);
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

  Future<bool> updateTransaction(int productId, int subQuantity) async {
    final product = _products.firstWhere((element) => element.id == productId);
    if (product.totalAmount >= subQuantity) {
      final newTotal = product.totalAmount - subQuantity;
      _products.removeWhere((element) => element.id == productId);
      _products.add(
        Product(
          id: product.id,
          title: product.title,
          description: product.description,
          unitId: product.unitId,
          quantity: product.quantity,
          totalAmount: newTotal,
        ),
      );
      return true;
    } else {
      return false;
    }
  }

  Future<void> addTransaction(int productId, int subQuantity) async {
    final product = _products.firstWhere((element) => element.id == productId);
    if (product.totalAmount >= subQuantity) {
      log('is ok');
      final newTotal = product.totalAmount - subQuantity;
      log('$newTotal       ${product.totalAmount}   $subQuantity');
      _products.removeWhere((element) => element.id == productId);
      _products.add(
        Product(
          id: product.id,
          title: product.title,
          description: product.description,
          unitId: product.unitId,
          quantity: product.quantity,
          totalAmount: newTotal,
        ),
      );

      _transactions.add(
        TransAction(
          id: math.Random().nextInt(5000),
          quantity: subQuantity,
          productId: productId,
          date: DateTime.now(),
        ),
      );
    }

    notifyListeners();
  }
}
