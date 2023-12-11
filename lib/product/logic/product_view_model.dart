import 'package:flutter/material.dart';
import 'package:store_warehouse/core/database/dao/product_dao.dart';
import 'package:store_warehouse/core/database/db_config.dart';
import 'package:store_warehouse/product/data/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  final db = ProductDAO();
  List<ProductModel> productList = [];
  Future<List<ProductModel>> fetchProducts() async {
    final x = await db.getProducts();
    productList = x;
    return x;
  }

  Future<List<Map<String, dynamic>>>
      fetchProductsWithQuantitiesAndUnitTitles() async {
    final db = await DbConfig.getInstance();
    final x = await db.rawQuery('''
    SELECT
        p.id AS product_id,
        p.name AS product_name,
        u.name AS unit_title,
        COALESCE(SUM(t.amount), 0) AS quantity
    FROM
        product p
    JOIN
        unit u ON p.unit_id = u.id
    LEFT JOIN
        transactions t ON p.id = t.product_id
    GROUP BY
        p.id, p.name, u.name;
  ''');
    return x;
  }

  Future<void> addProduct(ProductModel product) async {
    final result = await db.addProduct(product);
    print(result);
  }
}
