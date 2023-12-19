import 'package:flutter/material.dart';
import 'package:store_warehouse/core/database/dao/transaction_dao.dart';
import 'package:store_warehouse/core/utils/enum/report_type.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';

class ReportViewModel extends ChangeNotifier {
  final TransactionDAO transactionDAO = TransactionDAO();
  List<TransactionModel> todayReport = [];
  List<TransactionModel> weekReport = [];
  List<TransactionModel> monthReport = [];
  List<TransactionModel> customReport = [];

  ReportType reportType = ReportType.day;

  Future<void> getTodayReport() async {
    final DateTime now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final result = await transactionDAO.report(startOfToday, endOfToday);
    todayReport = result;
    notifyListeners();
  }
}
