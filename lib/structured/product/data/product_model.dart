class ProductModel {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final int unitId;
  final String unitTitle;
  final int quantity;
  final int totalAmount;
  final String notes;

  ProductModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.unitId,
    required this.unitTitle,
    required this.quantity,
    required this.totalAmount,
    required this.notes,
  });

  factory ProductModel.fromSQL(Map<String, dynamic> record) => ProductModel(
        id: record['id'],
        title: record['title'],
        description: record['description'],
        imagePath: record['imagePath'],
        unitId: record['unitId'] as int,
        unitTitle: record['unitTitle'],
        quantity: record['quantity'] as int,
        totalAmount: record['totalAmount'] as int,
        notes: record['notes'],
      );
}
