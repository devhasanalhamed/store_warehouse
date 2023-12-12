class TransactionModel {
  final int transactionId;
  final int productId;
  final int transactionTypeId;
  final int amount;
  final String notes;
  final DateTime createdAt;

  TransactionModel({
    required this.transactionId,
    required this.productId,
    required this.transactionTypeId,
    required this.amount,
    required this.notes,
    required this.createdAt,
  });
}
