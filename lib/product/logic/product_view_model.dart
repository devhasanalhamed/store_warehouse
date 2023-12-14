import 'package:flutter/material.dart';
import 'package:store_warehouse/core/database/dao/product_dao.dart';
import 'package:store_warehouse/product/data/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  final db = ProductDAO();
  List<ProductModel> productList = [];

  Future<void> getProducts() async {
    final x = await db.fetchProducts();
    productList = x;
    notifyListeners();
  }

  Future<void> addProduct(ProductModel product) async {
    await db.insert(product);
    getProducts();
  }

  Future<void> updateProduct(ProductModel product) async {
    await db.update(product);
    getProducts();
  }

  Future<void> deleteProduct(int id) async {
    await db.delete(id);
    getProducts();
  }

  ProductModel getProductById(int id) {
    return productList.firstWhere((element) => element.id == id);
  }
}
