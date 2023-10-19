import 'package:equatable/equatable.dart';
import 'package:store_warehouse/transactions/domain/entity/uint.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String category;
  final Unit unit;
  final int quantity;

  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.unit,
    required this.quantity,
  });
  @override
  List<Object> get props => [id, title, category, unit, quantity];
}
