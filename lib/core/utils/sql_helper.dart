import 'dart:developer';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<void> createTables(Database database) async {
    await database.execute("""
      CREATE TABLE units(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      unitPerPiece int,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
      """);

    await database.execute("""
      CREATE TABLE transaction_type(
      id INTEGER PRIMARY KEY NOT NULL,
      title TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP);

      INSERT INTO transaction_type(title)
      VALUES ('0','سحب'), ('1','إضافة');
      """);

    await database.execute("""

    CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      description TEXT,
      imagePath TEXT,
      unitId int,
      quantity int,
      totalAmount int,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY(unitId) REFERENCES units(id))
      """);

    await database.execute("""
      CREATE TABLE transactions(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      transactionId int,
      productId int,
      quantity int,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY(productId) REFERENCES items(id),
      FOREIGN KEY(transactionId) REFERENCES transaction_type(id)
      )
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

  static Future<List<Map<String, dynamic>>> getTransactionTypeId() async {
    final db = await SQLHelper.db();
    return db.query('transaction_type', orderBy: 'id');
  }

  static Future<int> createTransaction(
      int transactionTypeId, int productId, int quantity) async {
    final db = await SQLHelper.db();

    final data = {
      "transactionId": transactionTypeId,
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

  static Future<int> updateQuantity(
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

  static Future<List<Map<String, dynamic>>> getUnits() async {
    final db = await SQLHelper.db();
    return db.query('units', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getUnitById(int unitId) async {
    final db = await SQLHelper.db();
    return db.query('units',
        orderBy: 'id', limit: 1, where: 'id = ?', whereArgs: [unitId]);
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.rawQuery("""
    SELECT p.id, p.title, p.description, 
    p.imagePath, p.unitId, p.totalAmount, p.quantity,
    u.title as unitTitle FROM items as p JOIN units as u
    ON p.unitId = u.id
    """);
  }

  static Future<List<Map<String, dynamic>>> getItemById(int id) async {
    final db = await SQLHelper.db();
    return await db.rawQuery("""
    SELECT p.id, p.title, p.description, 
    p.imagePath, p.unitId, p.totalAmount, p.quantity,
    u.title as unitTitle FROM items as p JOIN units as u
    ON p.unitId = u.id
    WHERE P.id = ?
    """, [id]);
  }

  static Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await SQLHelper.db();
    return db.query('transactions', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>>
      productTransactionViewModel() async {
    final db = await SQLHelper.db();
    return db.rawQuery("""
    SELECT t.id, t.quantity, t.createdAt,  t.transactionId as transactionId,
    s.title, s.id as productId,
    s.imagePath FROM transactions as t
    JOIN items as s
    ON t.productId = s.id  
    """);
  }

  static Future<void> deleteProduct(int productId) async {
    final db = await SQLHelper.db();
    db.rawDelete('DELETE FROM transactions WHERE productId = ?', [productId]);
    db.rawDelete('DELETE FROM items WHERE id = ?', [productId]);
  }
}
