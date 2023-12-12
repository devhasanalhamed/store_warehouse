import 'package:store_warehouse/core/database/db_config.dart';
import 'package:store_warehouse/core/database/tables/unit_table.dart';
import 'package:store_warehouse/unit/data/unit_model.dart';

class UnitDAO {
  Future<List<UnitModel>> fetchUnits() async {
    final db = await DbConfig.getInstance();

    final List<Map<String, dynamic>> productsData =
        await db.query(UnitTable.tableName);
    return productsData.map((data) {
      return UnitModel(
        id: data['id'],
        name: data['name'],
      );
    }).toList();
  }

  Future<String> fetchUnitNameById() async {
    final db = await DbConfig.getInstance();
    final data = await db.query(
      UnitTable.tableName,
    );
    print(data);
    return ' ';
  }
}
