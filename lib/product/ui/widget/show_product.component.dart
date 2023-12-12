import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';

class ShowProductName extends StatelessWidget {
  final int productId;
  const ShowProductName({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = context.read<ProductViewModel>().getProductById(productId);
    return Text(
      product.title,
      textAlign: TextAlign.center,
    );
  }
}
