import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/shared/models/unit_provider.dart';
import 'package:store_warehouse/core/utils/sql_helper.dart';
import 'package:store_warehouse/products/controller/product_controller.dart';
import 'package:store_warehouse/products/model/product.dart';
import 'package:store_warehouse/products/view/screen/add_product_screen.dart';
import 'package:store_warehouse/products/view/screen/products_screen.dart';
import 'package:store_warehouse/transactions/controller/transaction_controller.dart';
import 'package:store_warehouse/transactions/view/transactions_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await deleteDatabase('inventory');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UnitProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionController(),
        ),
      ],
      child: MaterialApp(
        title: 'مستودعي',
        theme: ThemeData(
          fontFamily: 'Cairo',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomePage(),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(),
            ),
          );
        },
        child: const Icon(Icons.add_box),
      ),
      FloatingActionButton(
        onPressed: () {
          int productId = 0;
          int quantity = 0;
          final x = Provider.of<ProductController>(context, listen: false)
              .getProduct();
          showDialog(
            context: context,
            builder: (s) => Dialog(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  width: 350,
                  height: 200,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder<List<Product>>(
                        future: x,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DropdownButtonFormField(
                              value: null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'أختر نوع المنتج',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                              ),
                              items: snapshot.data!
                                  .map((e) => DropdownMenuItem(
                                        alignment: Alignment.centerRight,
                                        value: e.id,
                                        child: Text(e.title),
                                      ))
                                  .toList(),
                              onChanged: (value) => productId = value!,
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
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
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                              ),
                              onChanged: (value) => quantity = int.parse(value),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () => Provider.of<TransactionController>(
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
        backgroundColor: const Color.fromARGB(255, 12, 70, 117),
        child: const Icon(Icons.addchart),
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        drawer: Drawer(
          child: Container(
            color: const Color(0xFFFEFEFE),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Divider(color: Colors.deepPurple),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    String unitTitle = '';
                    int unitPerPiece = 0;
                    showDialog(
                      context: context,
                      builder: (s) => Dialog(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            height: 350,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 16.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'أسم الوحدة',
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                  ),
                                  onChanged: (value) => unitTitle = value,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'العدد بالحبة',
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                  ),
                                  onChanged: (value) =>
                                      unitPerPiece = int.parse(value),
                                ),
                                ElevatedButton(
                                  onPressed: () => Provider.of<UnitProvider>(
                                          context,
                                          listen: false)
                                      .addUnit(unitTitle, unitPerPiece)
                                      .then(
                                        (value) =>
                                            {Navigator.of(context).pop()},
                                      ),
                                  child: const Text('إضافة وحدة جديد'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'إضافة وحدة جديدة',
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const Divider(color: Colors.deepPurple),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'تصدير إلى csv(SOON)',
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const Divider(color: Colors.deepPurple),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'إستيراد إلى csv(SOON)',
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const Divider(color: Colors.deepPurple),
                TextButton(
                  onPressed: () {
                    SQLHelper.deleteDB();
                  },
                  child: const Text(
                    'حذف قاعدة البيانات',
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const Divider(color: Colors.deepPurple),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'معملي',
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
    );
  }

  void setIndicator(int value) => setState(() {
        indicator = value;
      });
}
