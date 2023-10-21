import 'package:sqflite/sqflite.dart';
import 'package:store_warehouse/core/utils/services/database_service.dart';
import 'package:store_warehouse/core/warehouse/data/model/product_model.dart';

class ProductDB {
  final tableName = 'products';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "title" TEXT NOT NULL,
      "category" TEXT NOT NULL,
      "unitId" INTEGER NOT NULL,
      "quantity" INTEGER NOT NULL);
      """);
  }

  Future<int> create({
    required int id,
    required String title,
    required String category,
    required int unitId,
    required int quantity,
  }) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      """INSERT INTO $tableName (id, title, category, unitId, quantity)
        VALUES (?,?,?,?,?)
        """,
      [id, title, category, unitId, quantity],
    );
  }

  Future<List<ProductModel>> fetchAll() async {
    final database = await DatabaseService().database;
    final products = await database.rawQuery('''SELECT * from $tableName''');
    return products.map((e) => ProductModel.fromSqfliteDatabase(e)).toList();
  }
}
