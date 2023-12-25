import 'dart:io';
import 'dart:typed_data';

import 'package:excel/excel.dart' as ex;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:store_warehouse/core/database/dao/transaction_dao.dart';
import 'package:store_warehouse/core/utils/enum/report_type.dart';
import 'package:store_warehouse/product/data/product_model.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';
import 'package:path/path.dart' as path;

class ReportViewModel extends ChangeNotifier {
  final List<ProductModel> productList;
  ReportViewModel({
    required this.productList,
  });

  final TransactionDAO transactionDAO = TransactionDAO();
  List<TransactionModel> todayReport = [];
  List<TransactionModel> weekReport = [];
  List<TransactionModel> monthReport = [];
  List<TransactionModel> customReport = [];
  List<Map<String, dynamic>> reportFiles = [];

  ReportType reportType = ReportType.month;

  List<bool> toggleBoolean = [true, false, false, false];

  void updateReportType(int index) {
    switch (index) {
      case 0:
        reportType = ReportType.day;
        toggleBoolean = [true, false, false, false];
        break;
      case 1:
        reportType = ReportType.week;
        toggleBoolean = [false, true, false, false];
        break;
      case 2:
        reportType = ReportType.month;
        toggleBoolean = [false, false, true, false];
        break;
      case 3:
        reportType = ReportType.custom;
        toggleBoolean = [false, false, false, true];
        break;
      default:
        reportType = ReportType.day;
        toggleBoolean = [true, false, false, false];
    }
    getReportFunction;
    notifyListeners();
  }

  Future<void>? get getReportFunction {
    switch (reportType) {
      case ReportType.day:
        return getTodayReport();
      case ReportType.week:
        return getWeekReport();
      case ReportType.month:
        return getMonthReport();
      case ReportType.custom:
        return null;
    }
  }

  List<TransactionModel> get getReportList {
    switch (reportType) {
      case ReportType.day:
        return todayReport;
      case ReportType.week:
        return weekReport;
      case ReportType.month:
        return monthReport;
      case ReportType.custom:
        return customReport;
    }
  }

  Future<void> exportReport() async {
    try {
      // Create an Excel workbook
      final excel = ex.Excel.createExcel();

      // Add a sheet to the workbook
      final sheet = excel['Sheet1'];

      sheet.isRTL = true;

      // Define a cell style with borders
      ex.CellStyle cellStyle = ex.CellStyle(
        bottomBorder: ex.Border(
          borderStyle: ex.BorderStyle.Thin,
          borderColorHex: 'FF000000',
        ),
        rightBorder: ex.Border(
          borderStyle: ex.BorderStyle.Thin,
          borderColorHex: 'FF000000',
        ),
        horizontalAlign: ex.HorizontalAlign.Center,
      );

      // Add headers to the sheet with borders
      sheet.appendRow([
        const ex.TextCellValue('المنتج'),
        const ex.TextCellValue('نوع العملية'),
        const ex.TextCellValue('الكمية'),
        const ex.TextCellValue('ملاحظات'),
        const ex.TextCellValue('التاريخ')
      ]);

      // Auto-fit columns to fit content
      for (int colIndex = 0; colIndex < sheet.maxColumns; colIndex++) {
        sheet.setColumnAutoFit(colIndex);
      }

      // Add transaction data to the sheet with borders
      for (var transaction in getReportList) {
        sheet.appendRow([
          ex.TextCellValue(
            productList
                .firstWhere((element) => element.id == transaction.productId)
                .title,
          ),
          ex.TextCellValue(
              transaction.transactionTypeId == 1 ? 'اضافة' : 'سحب'),
          ex.TextCellValue(transaction.amount.toString()),
          ex.TextCellValue(transaction.notes.toString()),
          ex.TextCellValue(transaction.createdAt.toUtc().toString()),
        ]);
      }

      // Apply cell style with borders to all cells in the sheet
      for (var row in sheet.rows) {
        for (var cell in row) {
          cell!.cellStyle = cellStyle;
          print('1');
        }
      }

      // Get the app's documents directory
      final Directory? appDocDir = await getExternalStorageDirectory();
      final today = DateTime.now();

      // Define the Excel file path
      String excelPath =
          '${appDocDir!.path}/report_${reportType.name}_${today.year}_${today.month}_${today.day}.xlsx';

      // Save the Excel file
      final List<int>? bytes = excel.encode();
      File(excelPath).writeAsBytesSync(Uint8List.fromList(bytes!));
    } catch (e) {
      // Handle exceptions (e.g., log, show an error message, etc.)
    }
    getReportFiles();
  }

  Future<void> getTodayReport() async {
    final DateTime now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final result = await transactionDAO.report(startOfToday, endOfToday);
    todayReport = result;
    print('todayReport');
    notifyListeners();
  }

  Future<void> getWeekReport() async {
    final DateTime now = DateTime.now();
    // Find the first day of the week (Sunday is 7, Monday is 1)
    int firstDayOfWeek = DateTime.sunday;
    int currentDayOfWeek = now.weekday;
    int difference = currentDayOfWeek - firstDayOfWeek;
    if (difference < 0) {
      difference += 7;
    }

// Calculate the start and end of the week
    DateTime startOfWeek =
        DateTime(now.year, now.month, now.day - difference, 0, 0, 0);
    DateTime endOfWeek =
        DateTime(now.year, now.month, now.day + (6 - difference), 23, 59, 59);
    final result = await transactionDAO.report(startOfWeek, endOfWeek);
    weekReport = result;
    notifyListeners();
  }

  Future<void> getMonthReport() async {
    final DateTime now = DateTime.now();
    // Find the first day of the week (Sunday is 7, Monday is 1)
    DateTime startOfMonth = DateTime(now.year, now.month, 1, 0, 0, 0);

// Calculate the end of the month
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    final result = await transactionDAO.report(startOfMonth, endOfMonth);
    monthReport = result;
    notifyListeners();
  }

  Future<void> getCustomReport(DateTime startDate, DateTime endDate) async {
    final result = await transactionDAO.report(startDate, endDate);
    customReport = result;
    notifyListeners();
  }

  Future<void> getReportFiles() async {
    final Directory? dir = await getExternalStorageDirectory();
    if (dir == null) return;

    final listOfReports = dir
        .listSync()
        .map((e) => {'path': e.path, 'name': path.basename(e.path)})
        .toList()
      ..reversed;
    reportFiles = [...listOfReports.reversed];
    notifyListeners();
  }
}
