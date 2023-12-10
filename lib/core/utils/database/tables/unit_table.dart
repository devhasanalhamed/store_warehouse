class UnitTable {
  static const String tableName = 'unit';

  static String create() => """
  CREATE TABLE unit (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
  );
  """;

  static String insert() => """
  INSERT INTO unit (name)
    VALUES
    ('جرام'),
    ('لتر'),
    ('حبة');
""";
}
