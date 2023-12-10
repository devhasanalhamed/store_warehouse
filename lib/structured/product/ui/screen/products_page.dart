import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/structured/product/logic/product_view_model.dart';
import 'package:store_warehouse/structured/product/ui/widget/product_widget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: context.read<ProductViewModel>().productList.length,
      itemBuilder: (context, index) => ProductWidget(
          product: context.read<ProductViewModel>().productList[index]),
    );
  }
}
