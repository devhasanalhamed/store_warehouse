import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/transactions/presentation/controller/transactions_provider.dart';
import 'package:store_warehouse/transactions/presentation/screens/transactions_screen.dart';

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
            create: (context) => TransactionsProvider(),
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
    TransactionsScreen(),
    TransactionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Container(
                    width: 200,
                    height: 200,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  Provider.of<TransactionsProvider>(context,
                                          listen: false)
                                      .addProduct(null, null, null),
                              child: Text('data'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
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
