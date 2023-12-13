import 'package:sqflite/sqflite.dart';
import 'package:store_warehouse/core/database/db_config.dart';
import 'package:store_warehouse/core/database/tables/transaction_table.dart';
import 'package:store_warehouse/core/utils/sql_helper.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';

class TransactionDAO {
  TransactionDAO();

  Future<int> insert(TransactionModel transaction) async {
    final db = await DbConfig.getInstance();
    final data = {
      "product_id": transaction.productId,
      "type": 1,
      "amount": transaction.amount,
      "notes": transaction.notes,
    };

    final id = await db.insert(
      TransactionTable.tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<TransactionModel>> fetch() async {
    final db = await DbConfig.getInstance();

    final List<Map<String, dynamic>> transactionData =
        await db.query(TransactionTable.tableName);
    return transactionData.map((data) {
      return TransactionModel(
        transactionId: data['id'],
        productId: data['product_id'],
        transactionTypeId: data['type'],
        amount: data['amount'],
        notes: data['notes'] ?? '',
        createdAt: DateTime.parse(data['created_at']),
      );
    }).toList();
  }

  Future<int> delete(int id) async {
    final db = await DbConfig.getInstance();
    return await db.delete(
      TransactionTable.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

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
