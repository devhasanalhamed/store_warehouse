import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/utils/app_string.dart';
import 'package:store_warehouse/home/logic/home_view_model.dart';
import 'package:store_warehouse/home/ui/widget/custom_bottom_navigation_bar.dart';
import 'package:store_warehouse/product/ui/screen/add_product_screen.dart';
import 'package:store_warehouse/product/ui/screen/products_page.dart';
import 'package:store_warehouse/transaction/ui/transactions_page.dart';

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
    final floatingActionButtons = [
      // FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: AppString.settings,
      //   child: const Icon(Icons.add),
      // ),
      // FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: AppString.reports,
      //   child: const Icon(Icons.add),
      // ),
      // FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: AppString.home,
      //   child: const Icon(Icons.add),
      // ),
      null,
      null,
      null,
      FloatingActionButton(
        onPressed: () {},
        tooltip: AppString.transactions,
        child: const Icon(Icons.point_of_sale),
      ),
      FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddProductScreen(),
          ));
        },
        tooltip: AppString.products,
        child: const Icon(Icons.add),
      ),
    ];
    return Selector<HomeViewModel, int>(
      selector: (_, provider) => provider.currentIndex,
      builder: (_, currentIndex, __) => Scaffold(
        appBar: AppBar(
          title: const Text('معملي'),
          centerTitle: true,
        ),
        body: pages[currentIndex],
        floatingActionButton: floatingActionButtons[currentIndex],
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) =>
              context.read<HomeViewModel>().updateCurrentIndex(index),
        ),
      ),
    );
  }
}