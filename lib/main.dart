import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/products/products_provider.dart';
import 'package:store_warehouse/products/products_screen.dart';
import 'package:store_warehouse/shared/unit_provider.dart';
import 'package:store_warehouse/transactions/transactions_provider.dart';
import 'package:store_warehouse/transactions/transactions_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Cairo',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProductsProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => TransactionsProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UnitProvider(),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int indicator = 1;
  List<Widget> screens = const [
    ProductsScreen(),
    TransactionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    List<FloatingActionButton> floatingActionButton = [
      FloatingActionButton(
        onPressed: () {
          String title = '';
          String description = '';
          int quantity = 0;
          int unitPerPiece = 0;
          final unitList =
              Provider.of<UnitProvider>(context, listen: false).list;
          showDialog(
            context: context,
            builder: (s) => Dialog(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  width: 300,
                  height: 450,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 12.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'أسم المنتج',
                        ),
                        onChanged: (value) => title = value,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'وصف المنتج',
                        ),
                        onChanged: (value) => description = value,
                      ),
                      Row(
                        children: [
                          const Text(
                            'نوع الوحدة',
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: DropdownButtonFormField(
                              value: null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'أسم المنتج',
                              ),
                              items: unitList
                                  .map((e) => DropdownMenuItem(
                                        alignment: Alignment.centerRight,
                                        value: e.id,
                                        child: Text(e.title),
                                      ))
                                  .toList(),
                              onChanged: (value) => unitPerPiece = value!,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'الكمية',
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'أدخل الكمية',
                              ),
                              onChanged: (value) => quantity = int.parse(value),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('إضافة وحدة جديدة'),
                      ),
                      ElevatedButton(
                        onPressed: () => Provider.of<ProductsProvider>(context,
                                listen: false)
                            .addProduct(
                                title, description, unitPerPiece, quantity)
                            .then((value) => {Navigator.of(context).pop()}),
                        child: const Text('data'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add_box),
      ),
      FloatingActionButton(
        onPressed: () {
          int productId = 0;
          int quantity = 0;
          final productsList =
              Provider.of<ProductsProvider>(context, listen: false).products;
          showDialog(
            context: context,
            builder: (s) => Dialog(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  width: 300,
                  height: 300,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 12.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButtonFormField(
                        value: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'أختر نوع المنتج',
                        ),
                        items: productsList
                            .map((e) => DropdownMenuItem(
                                  alignment: Alignment.centerRight,
                                  value: e.id,
                                  child: Text(e.title),
                                ))
                            .toList(),
                        onChanged: (value) => productId = value!,
                      ),
                      Row(
                        children: [
                          const Text(
                            'الكمية',
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'أدخل الكمية',
                              ),
                              onChanged: (value) => quantity = int.parse(value),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () => Provider.of<TransactionsProvider>(
                                context,
                                listen: false)
                            .addTransaction(productId, quantity)
                            .then((value) => {Navigator.of(context).pop()}),
                        child: const Text('إضافة عملية'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.addchart),
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<TransactionsProvider>(
        builder: (context, value, child) => Scaffold(
          drawer: Drawer(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          appBar: AppBar(
            title: const Text(
              'warehouse',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          floatingActionButton: floatingActionButton[indicator],
          body: screens[indicator],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: indicator,
            onTap: (value) => setIndicator(value),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.warehouse),
                label: 'المخزن',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: 'العمليات',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setIndicator(int value) => setState(() {
        indicator = value;
      });
}
