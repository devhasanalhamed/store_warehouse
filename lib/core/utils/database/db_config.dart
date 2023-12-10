import 'package:sqflite/sqflite.dart';
import 'package:store_warehouse/core/utils/database/tables/product_table.dart';
import 'package:store_warehouse/core/utils/database/tables/transaction_table.dart';
import 'package:store_warehouse/core/utils/database/tables/transaction_type_table.dart';
import 'package:store_warehouse/core/utils/database/tables/unit_table.dart';
import 'package:store_warehouse/structured/product/data/product_model.dart';

class DbConfig {
  static Database? _db;

  static Future<Database> getInstance() async {
    _db ??= await openDatabase(
      'inventory7',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(UnitTable.create());
        await db.execute(UnitTable.insert());
        await db.execute(ProductTable.create());
        await db.execute(ProductTable.insert());
        await db.execute(TransactionTypeTable.create());
        await db.execute(TransactionTypeTable.insert());
        await db.execute(TransactionTable.create());
        await db.execute(TransactionTable.insert());
      },
    );
    return _db!;
  }

  static close() async {
    await _db!.close();
  }

  static Future<List<ProductModel>> getProducts() async {
    final db = await getInstance();
    final List<Map<String, dynamic>> productsData = await db.query('product');
    print(productsData);
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
