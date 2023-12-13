import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';
import 'package:store_warehouse/product/ui/widget/select_product_component.dart';
import 'package:store_warehouse/shared/widget/text_form_field_component.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';
import 'package:store_warehouse/transaction/logic/transaction_view_model.dart';

class AddTransactionScreen extends StatelessWidget {
  AddTransactionScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    int amount = 1;
    String notes = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة عملية'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDesign.largePadding),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(height: AppDesign.largePadding),
              SelectProductComponent(
                onChanged: (value) {},
              ),
              const SizedBox(height: AppDesign.largePadding),
              TextFormFieldComponent(
                hintText: 'الكمية',
                keyboardType: TextInputType.number,
                onSaved: (newValue) => amount = int.parse(newValue!),
              ),
              const SizedBox(height: AppDesign.largePadding),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(AppDesign.circularRadius),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius:
                              BorderRadius.circular(AppDesign.circularRadius),
                        ),
                        child: Center(child: Text('اضافة')),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius:
                              BorderRadius.circular(AppDesign.circularRadius),
                        ),
                        child: Center(child: Text('سحب')),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDesign.largePadding),
              TextFormFieldComponent(
                hintText: 'الملاحظات',
                onSaved: (newValue) => notes = newValue!,
              ),
              const SizedBox(height: AppDesign.largePadding),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<TransactionViewModel>()
                      .addTransaction(TransactionModel(
                        transactionId: 0,
                        productId: 1,
                        transactionTypeId: 1,
                        amount: 20,
                        notes: 'notes',
                        createdAt: DateTime.now(),
                      ))
                      .then((value) => Navigator.pop(context));
                },
                child: const Text('add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
