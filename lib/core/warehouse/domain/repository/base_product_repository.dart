import 'package:store_warehouse/transactions/domain/entity/product.dart';

abstract class BaseProductRepository {
  Future<List<Product>> getAllProducts();
  Future<void> addProduct();
}
