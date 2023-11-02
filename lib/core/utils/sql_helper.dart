import 'dart:developer';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<void> createTables(Database database) async {
    await database.execute("""
    CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      description TEXT,
      imagePath TEXT,
      unitId int,
      quantity int,
      totalAmount int,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
      """);

    await database.execute("""
      CREATE TABLE units(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      unitPerPiece int,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
      """);

    await database.execute("""
      CREATE TABLE transactions(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      productId int,
      quantity int,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
      """);
  }

  static Future<Database> db() async {
    return openDatabase('inventory', version: 1,
        onCreate: (Database database, int version) async {
      log('message');
      await createTables(database);
    });
  }

  static Future<void> deleteDB() async {
    deleteDatabase('inventory');
  }

  static Future<int> createItem(
    String title,
    String description,
    String imagePath,
    int unitId,
    int quantity,
    int totalAmount,
  ) async {
    final db = await SQLHelper.db();

    final data = {
      "title": title,
      "description": description,
      "imagePath": imagePath,
      "unitId": unitId,
      "quantity": quantity,
      "totalAmount": totalAmount
    };

    final id = await db.insert('items', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createTransaction(int productId, int quantity) async {
    final db = await SQLHelper.db();

    final data = {
      "productId": productId,
      "quantity": quantity,
    };

    final id = await db.insert('transactions', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createUnit(String title, int unitPerPiece) async {
    final db = await SQLHelper.db();

    final data = {
      "title": title,
      "unitPerPiece": unitPerPiece,
    };

    final id = await db.insert('units', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> updateSubQuantity(int productId, int totalAmount) async {
    final db = await SQLHelper.db();

    final data = {"totalAmount": totalAmount};

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

  // static Future<int> updateTransaction(int productId, int totalAmount) async {
  //   final db = await SQLHelper.db();

  //   final data = {"totalAmount": totalAmount};

  //   final result =
  //       await db.update('items', data, where: 'id = ?', whereArgs: [productId]);
  //   return result;
  // }

  static Future<int> updateAddQuantity(int productId, int totalAmount) async {
    final db = await SQLHelper.db();

    final data = {"totalAmount": totalAmount};

    final result =
        await db.update('items', data, where: 'id = ?', whereArgs: [productId]);
    return result;
  }

  static Future<List<Map<String, dynamic>>> getUnits() async {
    final db = await SQLHelper.db();
    return db.query('units', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItemById(int id) async {
    final db = await SQLHelper.db();
    return await db.query('items', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await SQLHelper.db();
    return db.query('transactions', orderBy: 'id');
  }

  static Future<void> deleteProduct(int productId) async {
    final db = await SQLHelper.db();
    db.rawDelete('DELETE FROM transactions WHERE productId = ?', [productId]);
    db.rawDelete('DELETE FROM items WHERE id = ?', [productId]);
  }
}
