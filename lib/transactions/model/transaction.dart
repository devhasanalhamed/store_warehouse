class Transaction {
  final int id;
  final int quantity;
  final int productId;
  final DateTime createdAt;

  Transaction({
    required this.id,
    required this.quantity,
    required this.productId,
    required this.createdAt,
  });

  factory Transaction.fromSQL(Map<String, dynamic> db) => Transaction(
        id: db['id'],
        quantity: db['quantity'],
        productId: db['productId'],
        createdAt: DateTime.parse(db['createdAt']),
      );
}
