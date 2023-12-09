import 'package:flutter/material.dart';
import 'package:store_warehouse/structured/product/ui/widget/product_widget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductWidget(),
        ProductWidget(),
        ProductWidget(),
        ProductWidget(),
        ProductWidget(),
        ProductWidget(),
        ProductWidget(),
      ],
    );
  }
}
