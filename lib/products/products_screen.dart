import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/products/product_widget.dart';
import 'package:store_warehouse/products/products_provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  ProductsScreenState createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).products;
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Expanded(
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) =>
                ProductWidget(product: products[index]),
          ),
        ),
      ],
    );
  }
}
