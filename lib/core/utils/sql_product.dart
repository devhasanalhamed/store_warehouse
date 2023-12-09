import 'package:sqflite/sqflite.dart';
import 'package:store_warehouse/core/utils/sql_helper.dart';

class SQLProductHelper {
  static Future<int> createItem(
    String title,
    String description,
    String imagePath,
    int unitId,
    int quantity,
    String notes,
    int totalAmount,
  ) async {
    final db = await SQLHelper.db();

    final data = {
      "title": title,
      "description": description,
      "imagePath": imagePath,
      "unitId": unitId,
      "quantity": quantity,
      "totalAmount": totalAmount,
      "notes": notes,
    };

    final id = await db.insert('items', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> updateTotalAmount(int productId, int totalAmount) async {
    final db = await SQLHelper.db();
    final data = {"totalAmount": totalAmount};

    final result =
        await db.update('items', data, where: 'id = ?', whereArgs: [productId]);
    return result;
  }

  static Future<int> updateQuantity(int productId, int quantity) async {
    final db = await SQLHelper.db();
    final data = {"quantity": quantity};

    final result =
        await db.update('items', data, where: 'id = ?', whereArgs: [productId]);
    return result;
  }

  static Future<int> updateQuantityOld(
      int productId, int totalAmount, int totalPerUnit) async {
    final db = await SQLHelper.db();
    final data = {"totalAmount": totalAmount, "quantity": totalPerUnit};

    final result =
        await db.update('items', data, where: 'id = ?', whereArgs: [productId]);
    return result;
  }

  static Future<int> editProduct(
    int productId,
    String title,
    String description,
    int unitId,
  ) async {
    final db = await SQLHelper.db();

    final data = {"title": title, "description": description, "unitId": unitId};

    final result =
        await db.update('items', data, where: 'id = ?', whereArgs: [productId]);
    return result;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.rawQuery("""
    SELECT p.id, p.title, p.description, 
    p.imagePath, p.unitId, p.totalAmount, p.quantity, p.notes,
    u.title as unitTitle FROM items as p JOIN units as u
    ON p.unitId = u.id
    """);
  }

  static Future<List<Map<String, dynamic>>> getItemById(int id) async {
    final db = await SQLHelper.db();
    return await db.rawQuery("""
    SELECT p.id, p.title, p.description, p.notes,
    p.imagePath, p.unitId, p.totalAmount, p.quantity,
    u.title as unitTitle FROM items as p JOIN units as u
    ON p.unitId = u.id
    WHERE P.id = ?
    """, [id]);
  }

  static Future<void> deleteProduct(int productId) async {
    final db = await SQLHelper.db();
    db.rawDelete('DELETE FROM transactions WHERE productId = ?', [productId]);
    db.rawDelete('DELETE FROM items WHERE id = ?', [productId]);
  }
}
