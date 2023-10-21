import 'package:store_warehouse/core/warehouse/domain/repository/base_product_repository.dart';

class AddProduct {
  final BaseProductRepository baseProductRepository;

  AddProduct({
    required this.baseProductRepository,
  });

  Future<void> addProduct() async {
    return baseProductRepository.addProduct();
  }
}
