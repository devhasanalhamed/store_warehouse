import 'package:store_warehouse/core/warehouse/domain/entity/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.category,
    required super.unitId,
    required super.quantity,
  });

  factory ProductModel.fromSqfliteDatabase(Map<String, dynamic> map) =>
      ProductModel(
        id: map['id']?.toInt() ?? 0,
        title: map['title'] ?? '',
        category: map['category'] ?? '',
        unitId: map['unitId']?.toInt() ?? 0,
        quantity: map['quantity']?.toInt() ?? 0,
      );
}
