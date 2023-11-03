import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:store_warehouse/core/mvc/models/unit.dart';
import 'package:store_warehouse/core/utils/sql_helper.dart';
import 'package:store_warehouse/products/model/product.dart';

class ProductController extends ChangeNotifier {
  File? imagePicker;
  bool showImageError = false;

  Future<List<Product>> getProduct() async {
    log('Function: getProduct');
    final dbList = await SQLHelper.getItems();
    return dbList.map((e) => Product.fromSQL(e)).toList();
  }

  Future<Unit> getUnitById(int unitId) async {
    log('Function: getUnitById');
    final dbList = await SQLHelper.getUnitById(unitId);
    final unit = dbList.map((e) => Unit.fromSQL(e)).toList();
    return unit.first;
  }

  Future<void> addProduct(
    String title,
    String description,
    String imagePath,
    int unitId,
    int quantity,
  ) async {
    log('Function: addProduct');
    final unit = await getUnitById(unitId);
    await SQLHelper.createItem(
      title,
      description,
      imagePath,
      unitId,
      quantity,
      (quantity * unit.unitPerPiece),
    );
    notifyListeners();
  }

  Future<Product> getProductById(int id) async {
    log('Function: getProductById');
    final dbList = await SQLHelper.getItemById(id);
    return dbList.map((e) => Product.fromSQL(e)).first;
  }

  Future<void> updateAddQuantity(int productId, int addQuantity) async {
    log('Function: updateAddQuantity');
    final product = await getProductById(productId);
    final productUnit = await getUnitById(product.unitId);

    final totalAmount = product.totalAmount + addQuantity;
    final newTotalPerUnit = totalAmount ~/ productUnit.unitPerPiece;

    SQLHelper.updateSubQuantity(productId, totalAmount, newTotalPerUnit);
    notifyListeners();
  }

  Future<Directory> getStoragePath() async {
    log('Function: getStoragePath');
    final Directory? appDocumentDir = await getExternalStorageDirectory();
    try {
      return appDocumentDir!;
    } catch (error) {
      log('error while fetching document directory $error');
      throw 'error while fetching document directory';
    }
  }

  Future<void> pickImage() async {
    log('Function: pickImage');
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage == null) return;
      imagePicker = File(pickedImage.path);
      showImageError = false;
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
    notifyListeners();
  }

  Future<File> saveImage() async {
    log('Function: saveImage');
    final appDocumentDir = await getStoragePath();
    try {
      File tempFile = File(imagePicker!.path);
      img.Image image = img.decodeImage(tempFile.readAsBytesSync())!;
      img.Image mImage = img.copyResize(image, width: 512);
      String imgType = imagePicker!.path.split('.').last;
      String mPath = '${appDocumentDir.path}/image_${DateTime.now()}.$imgType';
      File dFile = File(mPath);
      if (imgType == 'jpg' || imgType == 'jpeg') {
        dFile.writeAsBytesSync(img.encodeJpg(mImage));
      } else {
        dFile.writeAsBytesSync(img.encodePng(mImage));
      }
      removeCurrentImage();
      return dFile;
    } catch (error) {
      throw 'Error Saving Image To Directory';
    }
  }

  void removeCurrentImage() {
    log('Function: removeCurrentImage');
    imagePicker = null;
    showImageError = false;
  }

  void showImageErrorMessage() {
    log('Function: showImageErrorMessage');
    showImageError = true;
    notifyListeners();
  }

  Future<void> editProduct(
    int productId,
    String title,
    String description,
    int unitId,
  ) async {
    SQLHelper.editProduct(productId, title, description, unitId);
    notifyListeners();
  }

  Future<void> deleteProduct(Product product) async {
    log('Function: deleteProduct');
    File file = File(product.imagePath);
    file.delete();
    SQLHelper.deleteProduct(product.id);
  }
}
