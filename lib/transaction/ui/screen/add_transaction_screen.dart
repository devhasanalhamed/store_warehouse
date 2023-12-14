import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';
import 'package:store_warehouse/product/ui/widget/select_product_component.dart';
import 'package:store_warehouse/shared/widget/text_form_field_component.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';
import 'package:store_warehouse/transaction/logic/transaction_view_model.dart';
import 'package:store_warehouse/transaction_type/ui/choose_transaction_type_widget.dart';

class AddTransactionScreen extends StatelessWidget {
  AddTransactionScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    int productId = 0;
    int amount = 0;
    int transactionType = 2;
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
                onChanged: (value) => productId = value,
              ),
              const SizedBox(height: AppDesign.largePadding),
              TextFormFieldComponent(
                hintText: 'الكمية',
                keyboardType: TextInputType.number,
                onSaved: (newValue) => amount = int.parse(newValue!),
              ),
              const SizedBox(height: AppDesign.largePadding),
              ChooseTransactionTypeWidget(
                onChanged: (value) {
                  transactionType = int.parse(value);
                },
              ),
              const SizedBox(height: AppDesign.largePadding),
              TextFormFieldComponent(
                hintText: 'الملاحظات',
                onSaved: (newValue) => notes = newValue!,
              ),
              const SizedBox(height: AppDesign.largePadding),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context
                        .read<TransactionViewModel>()
                        .addTransaction(TransactionModel(
                          transactionId: 0,
                          productId: productId,
                          transactionTypeId: transactionType,
                          amount: amount,
                          notes: notes,
                          createdAt: DateTime.now(),
                        ))
                        .then((value) => Navigator.pop(context));
                  }
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
