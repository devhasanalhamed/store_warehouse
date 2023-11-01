class Product {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final int unitId;
  final int quantity;
  final int totalAmount;

  Product({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.unitId,
    required this.quantity,
    required this.totalAmount,
  });

  factory Product.fromSQL(Map<String, dynamic> record) => Product(
        id: record['id'],
        title: record['title'],
        description: record['description'],
        imagePath: record['imagePath'],
        unitId: record['unitId'] as int,
        quantity: record['quantity'] as int,
        totalAmount: record['totalAmount'] as int,
      );
}
