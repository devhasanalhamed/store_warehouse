import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String category;
  final int unitId;
  final int quantity;

  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.unitId,
    required this.quantity,
  });
  @override
  List<Object> get props => [id, title, category, unitId, quantity];
}
