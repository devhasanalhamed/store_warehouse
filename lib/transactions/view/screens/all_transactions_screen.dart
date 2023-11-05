import 'package:flutter/material.dart';

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('جميع العمليات'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('soon'),
        ),
      ),
    );
  }
}
