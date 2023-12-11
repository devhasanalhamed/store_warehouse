class TransactionTypeTable {
  static const String tableName = 'transaction_type';

  static String create() => """
  CREATE TABLE transaction_type (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
  );
  """;

  static String insert() => """
  INSERT INTO transaction_type (name)
    VALUES
    ('إضافة'),
    ('سحب');
""";
}
