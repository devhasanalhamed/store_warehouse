import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/home/logic/home_view_model.dart';
import 'package:store_warehouse/home/ui/screen/home_controller_screen.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';
import 'package:store_warehouse/report/logic/report_view_model.dart';
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
      startLocale: const Locale('ar', 'SA'),
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
          create: (context) => TransactionViewModel()..getTransactions(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => ProductViewModel()..getProducts(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<ProductViewModel, ReportViewModel>(
          create: (context) => ReportViewModel(productList: []),
          update: (context, productState, previous) =>
              ReportViewModel(productList: productState.productList)
                ..getReportFiles(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'مستودعي',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: 'Cairo',
          colorScheme: ColorScheme.fromSeed(
            primary: const Color(0xFF2E4CE5),
            seedColor: const Color(0xFF2E4CE5),
            background: const Color(0xFFFEFEFE),
          ),
          cardTheme: CardTheme(
            color: const Color(0xFF4C4C4C).withOpacity(0.1),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Color(0xFF4C4C4C),
            ),
            headlineSmall: TextStyle(
              color: Color(0xFF4C4C4C),
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              color: Color(0xFF4C4C4C),
              fontWeight: FontWeight.bold,
            ),
            headlineLarge: TextStyle(
              color: Color(0xFF4C4C4C),
              fontWeight: FontWeight.bold,
            ),
          ),
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
