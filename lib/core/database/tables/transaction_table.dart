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
  INSERT INTO transactions (product_id, amount, type)
    VALUES
    (1, 35, 1), -- Purchase of 5 units of Ice Cream A
    (1, -5, 1), -- Purchase of 5 units of Ice Cream A
    (1, -5, 1), -- Purchase of 5 units of Ice Cream A
    (1, 10, 1), -- Purchase of 5 units of Ice Cream A
    (2, 3, 2), -- Sale of 3 units of Ice Cream B
    (3, 2, 2); -- Return of 2 units of Ice Cream C
""";
}
