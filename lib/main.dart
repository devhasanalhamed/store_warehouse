import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/home/logic/home_view_model.dart';
import 'package:store_warehouse/home/ui/screen/home_controller_screen.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';
import 'package:store_warehouse/transaction/logic/transaction_view_model.dart';
import 'package:store_warehouse/transaction_type/logic/transaction_type_view_model.dart';
import 'package:store_warehouse/unit/logic/unit_view_model.dart';

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
        ),
        ChangeNotifierProvider(
          create: (context) => ProductViewModel()..getProducts(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => UnitViewModel()..getUnits(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionViewModel()..getTransactions(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionTypeViewModel()..getTransactionType(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'مستودعي',
        theme: ThemeData(
          fontFamily: 'Cairo',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeControllerScreen(),
      ),
    );
  }
}
