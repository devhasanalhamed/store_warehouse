import 'package:equatable/equatable.dart';

class TransAction extends Equatable {
  final int id;
  final int quantity;
  final int productId;
  final DateTime date;

  const TransAction({
    required this.id,
    required this.quantity,
    required this.productId,
    required this.date,
  });

  @override
  List<Object> get props => [id, quantity, productId, date];
}
