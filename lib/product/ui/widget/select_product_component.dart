import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/product/data/product_model.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';
import 'package:store_warehouse/shared/widget/drop_down_button_form_field_component.dart';

class SelectProductComponent extends StatelessWidget {
  final ValueChanged? onChanged;
  const SelectProductComponent({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ProductViewModel, List<ProductModel>>(
      selector: (_, productList) => productList.productList,
      builder: (_, productList, __) => DropDownButtonFormFieldComponent(
        hint: const Text('اختر من المنتجات'),
        items: [
          for (int i = 0; i < productList.length; i++)
            DropdownMenuItem(
              value: productList[i].id,
              child: Text(productList[i].title),
            ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
