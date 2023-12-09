import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/mvc/controller/unit_provider.dart';
import 'package:store_warehouse/products/controller/product_controller.dart';
import 'package:store_warehouse/products/view/screen/add_product_screen.dart';
import 'package:store_warehouse/products/view/screen/products_screen.dart';
import 'package:store_warehouse/structured/home/logic/home_view_model.dart';
import 'package:store_warehouse/structured/home/ui/screen/home_controller_screen.dart';
import 'package:store_warehouse/transactions/controller/transaction_controller.dart';
import 'package:store_warehouse/transactions/view/screens/add_transaction_screen.dart';
import 'package:store_warehouse/transactions/view/screens/transactions_screen.dart';

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
          create: (context) => HomeViewModel(),
        )
      ],
      child: MaterialApp(
        title: 'مستودعي',
        theme: ThemeData(
          fontFamily: 'Cairo',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomeControllerScreen(),
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
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddTransactionScreen(),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 12, 70, 117),
        child: const Icon(Icons.addchart),
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                                  onPressed: () {},
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
                    'استيراد إلى csv(SOON)',
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const Divider(color: Colors.deepPurple),
                TextButton(
                  onPressed: () {},
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
