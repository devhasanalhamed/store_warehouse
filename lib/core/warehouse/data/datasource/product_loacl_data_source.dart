import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_warehouse/core/warehouse/domain/entity/product.dart';

abstract class BaseProductDataSource {
  Future<List<Product>> getAllProducts();
  Future<void> addProduct();
}

class ProductDataSource extends BaseProductDataSource {
  @override
  Future<void> addProduct() async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, 'products');
    final db = openDatabase(path);

    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }
}
