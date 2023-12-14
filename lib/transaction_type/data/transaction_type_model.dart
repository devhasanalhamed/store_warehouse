class TransactionTypeModel {
  int id;
  String name;

  TransactionTypeModel({
    required this.id,
    required this.name,
  });

  factory TransactionTypeModel.fromRecord(Map<String, dynamic> record) {
    return TransactionTypeModel(
      id: record['id'] as int,
      name: record['name'] as String,
    );
  }
}
