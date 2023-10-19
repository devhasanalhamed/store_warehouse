import 'package:flutter/material.dart';
import 'package:store_warehouse/transactions/data/model/product_model.dart';
import 'package:store_warehouse/transactions/domain/entity/uint.dart';

class TransactionsProvider extends ChangeNotifier {
  List<ProductModel> products = [
    const ProductModel(
      id: 10,
      title: 'title',
      category: 'category',
      unit: Unit(id: 0, title: 'حبة', unitPerPiece: 1),
      quantity: 50,
    ),
    const ProductModel(
      id: 12,
      title: 'another product',
      category: 'category',
      unit: Unit(id: 0, title: 'حبة', unitPerPiece: 1),
      quantity: 104,
    ),
  ];

  void addProduct(String? title, String? category, int? quantity) {
    products.add(
      const ProductModel(
        id: 50,
        title: 'title',
        category: 'category',
        unit: Unit(id: 0, title: 'حبة', unitPerPiece: 1),
        quantity: 40,
      ),
    );
  }
}
