import 'package:store_warehouse/core/database/db_config.dart';
import 'package:store_warehouse/core/database/tables/transaction_type_table.dart';
import 'package:store_warehouse/transaction_type/data/transaction_type_model.dart';

class TransactionTypeDAO {
  TransactionTypeDAO();

  Future<List<TransactionTypeModel>> fetch() async {
    final db = await DbConfig.getInstance();
    final transactionTypeList = await db.query(TransactionTypeTable.tableName);
    return List.from(transactionTypeList
        .map((record) => TransactionTypeModel.fromRecord(record)));
  }
}
