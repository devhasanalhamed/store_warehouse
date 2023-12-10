class ProductTable {
  static const String tableName = 'product';

  static String create() => """
  CREATE TABLE product (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    image_path TEXT NOT NULL,
    note TEXT NOT NULL,
    unit_id INT NOT NULL,
    FOREIGN KEY (unit_id) REFERENCES unit(id)
  );
  """;

  static String insert() => """
  INSERT INTO product (name, description, image_path, note, unit_id)
    VALUES
    ('Ice Cream A', 'Delicious chocolate flavor', 'chocolate.jpg', 'Bestseller', 1),
    ('Ice Cream B', 'Classic vanilla taste', 'vanilla.jpg', 'Limited edition', 2),
    ('Ice Cream C', 'Strawberry delight', 'strawberry.jpg', 'Customer favorite', 1);
    """;
}
