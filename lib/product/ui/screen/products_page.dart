import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/product/data/product_model.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';
import 'package:store_warehouse/product/ui/widget/product_widget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ProductViewModel, List<ProductModel>>(
      selector: (_, provider) => provider.productList,
      builder: (_, productList, __) {
        if (productList.isNotEmpty) {
          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) =>
                ProductWidget(product: productList[index]),
          );
        }
        return Center(child: Text('empty'.tr()));
      },
    );
  }
}
