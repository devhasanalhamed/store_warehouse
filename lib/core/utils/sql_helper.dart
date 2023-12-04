import 'dart:developer';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<void> createTables(Database database) async {
    await database.execute("""
      CREATE TABLE units(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        unitPerPiece int,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );
      """);

    await database.execute(
      'INSERT INTO units(title, unitPerPiece) VALUES (?, ?), (?, ?), (?, ?)',
      ['حبة', 1, 'مل', 1, 'جرام', 1],
    );

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
      notes TEXT,
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
      notes TEXT,
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
}
