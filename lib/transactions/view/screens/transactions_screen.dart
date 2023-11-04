import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/mvc/models/transaction_product_view_model.dart';
import 'package:store_warehouse/transactions/controller/transaction_controller.dart';
import 'package:store_warehouse/transactions/view/widgets/transactions_widget.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  TransactionsScreenState createState() => TransactionsScreenState();
}

class TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    //! Build
    log('build: transaction screen has been built');
    return FutureBuilder<List<ProductTransactionViewModel>>(
      future: Provider.of<TransactionController>(context, listen: false)
          .getTransactionsViewModel(),
      builder: (context, snapshot) {
        //! Build
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: ListView(
                children: [
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'العمليات الأخيرة',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      for (var i in snapshot.data!)
                        TransactionsWidget(
                          transaction: i,
                        ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.history),
                        onPressed: () {},
                        label: const Text('عرض جميع العمليات'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.deepPurple,
                          backgroundColor: Colors.white,
                          elevation: 0.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/no_transactions.png',
                  width: 250,
                ),
                const Center(
                  child: Text('لا توجد عمليات بعد'),
                ),
              ],
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
