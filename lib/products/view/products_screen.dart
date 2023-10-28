import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/shared/models/products_transactions_provider.dart';
import 'package:store_warehouse/core/shared/models/unit_provider.dart';
import 'package:store_warehouse/products/model/product.dart';
import 'package:store_warehouse/products/view/product_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  ProductsScreenState createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<UnitProvider>(context).getUnits();
    return FutureBuilder<List<Product>>(
      future: Provider.of<ProductsTransactionsProvider>(context).getProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      ProductWidget(product: snapshot.data![index]),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
