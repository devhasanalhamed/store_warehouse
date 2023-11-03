class Unit {
  final int id;
  final String title;
  final int unitPerPiece;

  Unit({
    required this.id,
    required this.title,
    required this.unitPerPiece,
  });

  factory Unit.fromSQL(Map<String, dynamic> record) => Unit(
        id: record['id'] as int,
        title: record['title'],
        unitPerPiece: record['unitPerPiece'] as int,
      );
}
