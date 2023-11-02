import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:store_warehouse/core/utils/sql_helper.dart';
import 'package:store_warehouse/products/model/product.dart';

class ProductController extends ChangeNotifier {
  File? imagePicker;
  bool showImageError = false;

  Future<Directory> getStoragePath() async {
    final Directory? appDocumentDir = await getExternalStorageDirectory();
    try {
      return appDocumentDir!;
    } catch (error) {
      log('error while fetching document directory $error');
      throw 'error while fetching document directory';
    }
  }

  Future<void> pickImage() async {
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
    final appDocumentDir = await getStoragePath();
    try {
      File tempFile = File(imagePicker!.path);
      img.Image image = img.decodeImage(tempFile.readAsBytesSync())!;
      img.Image mImage = img.copyResize(image, width: 512);
      String imgType = imagePicker!.path.split('.').last;
      log(imgType);
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
    imagePicker = null;
    showImageError = false;
  }

  void showImageErrorMessage() {
    showImageError = true;
    notifyListeners();
  }

  Future<void> deleteProduct(Product product) async {
    File file = File(product.imagePath);
    file.delete();
    SQLHelper.deleteProduct(product.id);
  }
}
