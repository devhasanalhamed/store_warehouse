import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/mvc/view/widgets/drop_from_field_component.dart';
import 'package:store_warehouse/core/mvc/view/widgets/elevated_button_component.dart';
import 'package:store_warehouse/core/mvc/view/widgets/text_form_field_component.dart';
import 'package:store_warehouse/products/controller/product_controller.dart';
import 'package:store_warehouse/products/model/product.dart';
import 'package:store_warehouse/transactions/controller/transaction_controller.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  Product? product;
  int? quantity;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إضافة عملية'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16.0,
          ),
          child: ListView(
            children: [
              Consumer<ProductController>(builder: (context, provider, child) {
                log('build: consumer in add transaction has been built');
                return FutureBuilder<List<Product>>(
                  future: provider.getProduct(),
                  builder: (context, snapshot) {
                    log('build: future in add transaction has been built');
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          DropDownButtonFormFieldComponent(
                            label: 'اختر المنتج من القائمة',
                            dropList: snapshot.data!
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e.id,
                                    alignment: Alignment.centerRight,
                                    child: Text(e.title),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) async {
                              product = await provider.getProductById(value);
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 16.0),
                          if (product != null)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(product!.unitId.toString()),
                                    Text(product!.totalAmount.toString()),
                                  ],
                                ),
                                if (product!.totalAmount > 0)
                                  Column(
                                    children: [
                                      TextFormFieldComponent(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'error';
                                          }
                                          return null;
                                        },
                                        label: 'أدخل الكمية',
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) =>
                                            quantity = int.parse(value),
                                      ),
                                      const SizedBox(height: 16.0),
                                      ElevatedButtonComponent(
                                        onPressed: () =>
                                            Provider.of<TransactionController>(
                                                    context,
                                                    listen: false)
                                                .addTransaction(
                                                    product!.id, quantity!)
                                                .then((value) => {
                                                      Navigator.of(context)
                                                          .pop()
                                                    }),
                                        title: 'إضافة عملية',
                                      ),
                                    ],
                                  ),
                                if (product!.totalAmount == 0)
                                  const Text(
                                      'لايمكن اجراء عمليات على هذا المنتج'),
                              ],
                            ),
                        ],
                      );
                    } else {
                      return DropDownButtonFormFieldComponent(
                        label: 'يتم جلب المنتجات',
                        dropList: const [],
                        onChanged: (_) {},
                      );
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
