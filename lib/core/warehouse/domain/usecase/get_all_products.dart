import 'package:store_warehouse/core/warehouse/domain/repository/base_product_repository.dart';
import 'package:store_warehouse/transactions/domain/entity/product.dart';

class GetAllProducts {
  final BaseProductRepository baseProductRepository;

  GetAllProducts({
    required this.baseProductRepository,
  });

  Future<List<Product>> getAllProducts() async {
    return baseProductRepository.getAllProducts();
  }
}
