import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';
import 'package:store_warehouse/product/ui/widget/select_product_component.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';
import 'package:store_warehouse/transaction/logic/transaction_view_model.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة عملية'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDesign.largePadding),
        child: ListView(
          children: [
            const SizedBox(height: AppDesign.largePadding),
            SelectProductComponent(
              onChanged: (value) {},
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
                    ));
              },
              child: const Text('add'),
            ),
          ],
        ),
      ),
    );
  }
}
