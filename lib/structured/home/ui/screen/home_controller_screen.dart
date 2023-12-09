import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/structured/home/logic/home_view_model.dart';
import 'package:store_warehouse/structured/product/ui/products_page.dart';
import 'package:store_warehouse/structured/transaction/ui/transactions_page.dart';

class HomeControllerScreen extends StatelessWidget {
  const HomeControllerScreen({Key? key}) : super(key: key);

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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) =>
              context.read<HomeViewModel>().updateCurrentIndex(index),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.file_open),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Products',
            ),
          ],
        ),
      ),
    );
  }
}
