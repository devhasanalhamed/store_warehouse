import 'package:sqflite/sqflite.dart';
import 'package:store_warehouse/core/database/dao/product_dao.dart';
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
        await db.query(TransactionTable.tableName, orderBy: 'id DESC');
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

  Future<void> update(TransactionModel transaction) async {
    final db = await DbConfig.getInstance();
    final data = {
      "amount": transaction.amount,
      "notes": transaction.notes,
    };

    await db.update(
      TransactionTable.tableName,
      data,
      where: 'id = ?',
      whereArgs: [transaction.transactionId],
    );
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

  Future<List<TransactionModel>> report(DateTime from, DateTime to) async {
    final db = await DbConfig.getInstance();
    List<Map<String, dynamic>> report = await db.rawQuery("""
    SELECT * FROM ${TransactionTable.tableName} WHERE created_at BETWEEN ? AND ?
    ORDER BY id DESC
    """, [from.toUtc().toString(), to.toUtc().toString()]);

    return report
        .map(
          (record) => TransactionModel(
            transactionId: record['id'],
            productId: record['product_id'],
            transactionTypeId: record['type'],
            amount: record['amount'],
            notes: record['notes'] ?? '',
            createdAt: DateTime.parse(record['created_at']),
          ),
        )
        .toList();
  }

  Future<Map<String, dynamic>> fetchMostUsedProduct() async {
    final db = await DbConfig.getInstance();
    List<Map<String, Object?>> id = await db.rawQuery("""
    SELECT product_id, COUNT(*) as transaction_count
    FROM ${TransactionTable.tableName}
    GROUP BY product_id
    ORDER BY transaction_count DESC
    LIMIT 1;
    """);

    final product =
        await ProductDAO().fetchProductById(id.first['product_id'] as int);
    return product;
  }

  Future<Map<String, dynamic>> fetchLastTransaction() async {
    final db = await DbConfig.getInstance();
    List<Map<String, Object?>> lastTransaction = await db.rawQuery("""
    SELECT * FROM ${TransactionTable.tableName}
    ORDER BY id DESC LIMIT 1;
    """);
    return lastTransaction[0];
  }
}
