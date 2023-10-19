import 'package:equatable/equatable.dart';

class Unit extends Equatable {
  final int id;
  final String title;
  final int unitPerPiece;

  const Unit({
    required this.id,
    required this.title,
    required this.unitPerPiece,
  });

  @override
  List<Object> get props => [id, title, unitPerPiece];
}
