import 'package:store_warehouse/transactions/domain/entity/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.category,
    required super.unitId,
    required super.quantity,
  });
}
