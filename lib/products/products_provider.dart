import 'dart:math';

import 'package:flutter/material.dart';
import 'package:store_warehouse/transactions/data/model/product_model.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductModel> products = [];

  Future<void> addProduct(
      String title, String description, int unitId, int quantity) async {
    products.add(
      ProductModel(
        id: Random().nextInt(5000),
        title: title,
        category: description,
        unitId: unitId,
        quantity: quantity,
      ),
    );
    notifyListeners();
  }
}
