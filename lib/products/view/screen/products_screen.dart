import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/products/controller/product_controller.dart';
import 'package:store_warehouse/products/model/product_model.dart';
import 'package:store_warehouse/products/view/widget/product_widget.dart';
import 'package:store_warehouse/transactions/controller/transaction_controller.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  ProductsScreenState createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Text('');
  }
}
