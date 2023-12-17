class TransactionTable {
  static const String tableName = 'transactions';

  static String create() => """
  CREATE TABLE transactions(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INT NOT NULL,
    type INT NOT NULL,
    amount INT NOT NULL,
    notes TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (type) REFERENCES transaction_type(id)
  );
  """;

  static String insert() => """
INSERT INTO transactions (product_id, type, amount, notes)
    SELECT
      CAST(RANDOM() * 3 + 1 AS INT), -- Random product_id between 1 and 3
      CAST(RANDOM() * 2 + 1 AS INT), -- Random type between 1 and 2
      CAST(RANDOM() * 100 AS INT),   -- Random amount between 0 and 100
      'Random notes'                 -- Default notes value
    FROM generate_series(1, 100);     -- Generate 100 rows
    """;
}
