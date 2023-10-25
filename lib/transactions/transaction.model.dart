import 'package:store_warehouse/transactions/transaction.dart';

class TransactionModel extends TransAction {
  const TransactionModel({
    required super.id,
    required super.quantity,
    required super.productId,
    required super.date,
  });
}
