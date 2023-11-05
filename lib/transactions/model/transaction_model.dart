class TransactionModel {
  final int transactionId;
  final int productId;
  final String productName;
  final String productImagePath;
  final DateTime createdAt;
  final int quantity;

  TransactionModel({
    required this.transactionId,
    required this.productId,
    required this.productName,
    required this.productImagePath,
    required this.createdAt,
    required this.quantity,
  });

  factory TransactionModel.fromSQL(Map<String, dynamic> record) =>
      TransactionModel(
        transactionId: record['id'],
        productId: record['productId'],
        productName: record['title'],
        productImagePath: record['imagePath'],
        createdAt: DateTime.parse(record['createdAt']),
        quantity: record['quantity'],
      );
}
