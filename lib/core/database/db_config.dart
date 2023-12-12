import 'package:sqflite/sqflite.dart';
import 'package:store_warehouse/core/database/tables/product_table.dart';
import 'package:store_warehouse/core/database/tables/transaction_table.dart';
import 'package:store_warehouse/core/database/tables/transaction_type_table.dart';
import 'package:store_warehouse/core/database/tables/unit_table.dart';

class DbConfig {
  static Database? _db;

  static Future<Database> getInstance() async {
    _db ??= await openDatabase(
      'inventory',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(UnitTable.create());
        await db.execute(UnitTable.insert());
        await db.execute(ProductTable.create());
        await db.execute(TransactionTypeTable.create());
        await db.execute(TransactionTypeTable.insert());
        await db.execute(TransactionTable.create());
      },
    );
    return _db!;
  }

  static close() async {
    await _db!.close();
  }

  static delete() async {
    await deleteDatabase('inventory');
  }
}
