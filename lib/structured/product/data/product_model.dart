class ProductModel {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final int unitId;
  final String notes;

  ProductModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.unitId,
    required this.notes,
  });

  factory ProductModel.fromSQL(Map<String, dynamic> record) => ProductModel(
        id: record['id'],
        title: record['title'],
        description: record['description'],
        imagePath: record['imagePath'],
        unitId: record['unitId'] as int,
        notes: record['notes'],
      );
}
