import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/structured/home/logic/home_view_model.dart';
import 'package:store_warehouse/structured/home/ui/widget/custom_bottom_navigation_bar.dart';
import 'package:store_warehouse/structured/product/ui/screen/products_page.dart';
import 'package:store_warehouse/structured/transaction/ui/transactions_page.dart';

class HomeControllerScreen extends StatelessWidget {
  HomeControllerScreen({Key? key}) : super(key: key);

  final actionButtons = [
    FloatingActionButton(
      onPressed: () {},
      child: Text('data'),
    )
  ];

  final pages = const [
    Center(child: Text('screen')),
    Center(child: Text('reports')),
    Center(child: Text('home')),
    TransactionsPage(),
    ProductsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Selector<HomeViewModel, int>(
      selector: (_, provider) => provider.currentIndex,
      builder: (_, currentIndex, __) => Scaffold(
        appBar: AppBar(),
        body: pages[currentIndex],
        floatingActionButton: actionButtons.firstOrNull,
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) =>
              context.read<HomeViewModel>().updateCurrentIndex(index),
        ),
      ),
    );
  }
}
