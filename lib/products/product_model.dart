import 'package:store_warehouse/products/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.category,
    required super.unitId,
    required super.quantity,
  });
}
