import 'package:sqflite/sqflite.dart';
import 'package:store_warehouse/core/database/db_config.dart';
import 'package:store_warehouse/core/database/tables/product_table.dart';
import 'package:store_warehouse/product/data/product_model.dart';

class ProductDAO {
  late Database _db;

  ProductDAO() {
    _getDbInstance();
  }

  void _getDbInstance() async => _db = await DbConfig.getInstance();

  Future<int> addProduct(ProductModel product) async {
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

  Future<List<ProductModel>> getProducts() async {
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
}
