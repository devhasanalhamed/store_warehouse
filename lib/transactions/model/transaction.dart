class TransAction {
  final int id;
  final int quantity;
  final int productId;
  final DateTime createdAt;

  TransAction({
    required this.id,
    required this.quantity,
    required this.productId,
    required this.createdAt,
  });

  factory TransAction.fromSQL(Map<String, dynamic> db) => TransAction(
        id: db['id'],
        quantity: db['quantity'],
        productId: db['productId'],
        createdAt: DateTime.parse(db['createdAt']),
      );
}
