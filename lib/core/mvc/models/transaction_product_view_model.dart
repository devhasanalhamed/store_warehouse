class ProductTransactionViewModel {
  final int transactionId;
  final int productId;
  final String productName;
  final String productImagePath;
  final DateTime createdAt;
  final int quantity;

  ProductTransactionViewModel({
    required this.transactionId,
    required this.productId,
    required this.productName,
    required this.productImagePath,
    required this.createdAt,
    required this.quantity,
  });

  factory ProductTransactionViewModel.fromSQL(Map<String, dynamic> record) =>
      ProductTransactionViewModel(
        transactionId: record['id'],
        productId: record['productId'],
        productName: record['title'],
        productImagePath: record['imagePath'],
        createdAt: record['createdAt'],
        quantity: record['quantity'],
      );
}
