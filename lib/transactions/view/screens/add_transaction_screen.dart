import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/mvc/view/widgets/drop_from_field_component.dart';
import 'package:store_warehouse/core/mvc/view/widgets/elevated_button_component.dart';
import 'package:store_warehouse/core/mvc/view/widgets/text_form_field_component.dart';
import 'package:store_warehouse/products/controller/product_controller.dart';
import 'package:store_warehouse/products/model/product_model.dart';
import 'package:store_warehouse/transactions/controller/transaction_controller.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  ProductModel? product;
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
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Consumer<ProductController>(
                    builder: (context, provider, child) {
                  log('build: consumer in add transaction has been built');
                  return FutureBuilder<List<ProductModel>>(
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
                                    children: [
                                      const Text('العدد المتبقي: '),
                                      Text(product!.totalAmount.toString()),
                                    ],
                                  ),
                                  if (product!.totalAmount > 0)
                                    Column(
                                      children: [
                                        TextFormFieldComponent(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'كمية غير صحيحة';
                                              }
                                              return null;
                                            },
                                            label: 'أدخل الكمية',
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]'),
                                              ),
                                            ],
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                quantity = int.parse(value);
                                              }
                                            }),
                                        const SizedBox(height: 16.0),
                                        ElevatedButtonComponent(
                                          onPressed: () => addTransaction(),
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
      ),
    );
  }

  addTransaction() {
    if (formKey.currentState!.validate()) {
      Provider.of<TransactionController>(context, listen: false)
          .addTransaction(product!.id, quantity!, 0)
          .then((value) => {Navigator.of(context).pop()});
    } else {
      log('adding transaction is not valid ');
    }
  }
}
