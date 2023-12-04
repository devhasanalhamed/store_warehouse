import 'package:sqflite/sqflite.dart';
import 'package:store_warehouse/core/utils/sql_helper.dart';

class SQLTransactionHelper {
  static Future<List<Map<String, dynamic>>> getTransactionTypeId() async {
    final db = await SQLHelper.db();
    return db.query('transaction_type', orderBy: 'id');
  }

  static Future<int> createTransaction(
      int transactionTypeId, int productId, int quantity, String notes) async {
    final db = await SQLHelper.db();

    final data = {
      "transactionId": transactionTypeId,
      "productId": productId,
      "quantity": quantity,
      "notes": notes,
    };

    final id = await db.insert('transactions', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await SQLHelper.db();
    return db.query('transactions', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>>
      productTransactionViewModel() async {
    final db = await SQLHelper.db();
    return db.rawQuery("""
    SELECT t.id, t.quantity, t.createdAt, t.notes as transactionNotes,
    t.transactionId as transactionId,
    s.title, s.id as productId, s.notes as productNotes,
    s.unitId,
    s.imagePath FROM transactions as t
    JOIN items as s
    ON t.productId = s.id  
    """);
  }
}
