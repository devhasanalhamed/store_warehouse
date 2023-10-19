import 'package:store_warehouse/transactions/domain/repository/base_transactions_repository.dart';

class AddProductUseCase {
  final BaseTransactionRepository baseTransactionRepository;

  AddProductUseCase({
    required this.baseTransactionRepository,
  });

  void addProduct() {
    baseTransactionRepository.addProduct();
  }
}
