import 'package:flutter/material.dart';
import 'package:store_warehouse/core/utils/database/db_config.dart';
import 'package:store_warehouse/structured/product/data/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  List<ProductModel> productList = [];
  Future<List<ProductModel>> fetchProducts() async {
    print('here');
    final x = await DbConfig.getProducts();
    productList = x;
    print(x);
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
    print(x);
    return x;
  }
}
