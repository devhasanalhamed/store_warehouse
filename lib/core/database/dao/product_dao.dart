import 'package:sqflite/sqflite.dart';
import 'package:store_warehouse/core/database/db_config.dart';
import 'package:store_warehouse/core/database/tables/product_table.dart';
import 'package:store_warehouse/product/data/product_model.dart';

class ProductDAO {
  ProductDAO();

  Future<int> insert(ProductModel product) async {
    final db = await DbConfig.getInstance();
    final data = {
      "name": product.title,
      "description": product.description,
      "image_path": product.imagePath,
      "note": product.notes,
      "unit_id": product.unitId,
    };

    final id = await db.insert(
      ProductTable.tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<ProductModel>> fetchProducts() async {
    final db = await DbConfig.getInstance();

    final List<Map<String, dynamic>> productsData =
        await db.query(ProductTable.tableName);
    return productsData.map((data) {
      return ProductModel(
        id: data['id'],
        title: data['name'],
        description: data['description'],
        imagePath: data['image_path'],
        notes: data['note'],
        unitId: data['unit_id'],
      );
    }).toList();
  }

  Future<int> delete(int id) async {
    final db = await DbConfig.getInstance();
    return await db.delete(
      ProductTable.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> update(ProductModel product) async {
    final db = await DbConfig.getInstance();
    final data = {
      "name": product.title,
      "description": product.description,
      "image_path": product.imagePath,
      "note": product.notes,
      "unit_id": product.unitId,
    };
    await db.update(
      ProductTable.tableName,
      data,
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> fetchProductsCount() async {
    final db = await DbConfig.getInstance();
    List<Map<String, Object?>> count =
        await db.rawQuery('SELECT COUNT(*) FROM ${ProductTable.tableName}');
    return count.first.values.first as int;
  }

  Future<Map<String, dynamic>> fetchProductById(int id) async {
    final db = await DbConfig.getInstance();
    final product = await db.query(
      ProductTable.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return product.first;
  }
}
