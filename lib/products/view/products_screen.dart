import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/shared/models/products_transactions_provider.dart';
import 'package:store_warehouse/products/view/product_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  ProductsScreenState createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final products =
        Provider.of<ProductsTransactionsProvider>(context).products;
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
