import 'package:sqflite/sqflite.dart';
import 'package:store_warehouse/core/database/db_config.dart';
import 'package:store_warehouse/core/database/tables/transaction_table.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';

class TransactionDAO {
  TransactionDAO();

  Future<int> insert(TransactionModel transaction) async {
    final db = await DbConfig.getInstance();
    final data = {
      "product_id": transaction.productId,
      "type": transaction.transactionTypeId,
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

  Future<int> calculateProductQuantity(int productId) async {
    final db = await DbConfig.getInstance();
    var result = await db.rawQuery('''
    SELECT COALESCE(SUM(CASE WHEN type = '1' THEN amount ELSE -amount END), 0) as totalQuantity
    FROM ${TransactionTable.tableName}
    WHERE product_id = ?
  ''', [productId]);

    int totalQuantity = (result.first['totalQuantity'] as int?) ?? 0;
    return totalQuantity;
  }
}
