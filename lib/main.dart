import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/home/logic/home_view_model.dart';
import 'package:store_warehouse/home/ui/screen/home_controller_screen.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';
import 'package:store_warehouse/transaction/logic/transaction_view_model.dart';
import 'package:store_warehouse/transaction/ui/screen/all_transactions_screen.dart';
import 'package:store_warehouse/transaction_type/logic/transaction_type_view_model.dart';
import 'package:store_warehouse/unit/logic/unit_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar', 'SA'),
      child: const MyApp(),
    ),
  );
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
          create: (context) => UnitViewModel()..getUnits(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionTypeViewModel()..getTransactionType(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionViewModel()
            ..getTransactions()
            ..getReport(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => ProductViewModel()..getProducts(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'مستودعي',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: const Locale('ar', 'SA'),
        theme: ThemeData(
          fontFamily: 'Cairo',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeControllerScreen(),
        routes: {
          AllTransactionsScreen.routeName: (context) =>
              const AllTransactionsScreen(),
        },
      ),
    );
  }
}
