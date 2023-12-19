import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';
import 'package:store_warehouse/report/logic/report_view_model.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productList =
        Provider.of<ProductViewModel>(context, listen: false).productList;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesign.smallPadding,
        vertical: AppDesign.smallPadding,
      ),
      child: Consumer<ReportViewModel>(
        builder: (_, state, __) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('اليوم'),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 400,
              child: ListView(
                children: [
                  Table(
                    children: [
                      const TableRow(
                        children: [
                          Text('المنتج'),
                          Text('نوع العملية'),
                          Text('الكمية'),
                          Text('التاريخ'),
                          Text('الملاحظات'),
                        ],
                      ),
                      for (var transaction in state.todayReport)
                        TableRow(
                          children: [
                            Text(productList
                                .firstWhere((element) =>
                                    element.id == transaction.productId)
                                .title),
                            Text(transaction.transactionTypeId == 1
                                ? 'إضافة'
                                : 'سحب'),
                            Text(transaction.amount.toString()),
                            Text(transaction.createdAt.toIso8601String()),
                            Text(transaction.notes.toString()),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Create an Excel workbook
                  final excel = Excel.createExcel();

                  // Add a sheet to the workbook
                  final sheet = excel['Sheet1'];

                  // Add headers to the sheet
                  sheet.appendRow([
                    const TextCellValue('رقم العملية'),
                    const TextCellValue('المنتج'),
                    const TextCellValue('نوع العملية'),
                    const TextCellValue('الكمية'),
                    const TextCellValue('الملاحظات'),
                    const TextCellValue('تاريخ العملية')
                  ]);

                  // Add transaction data to the sheet
                  for (var transaction in state.todayReport) {
                    sheet.appendRow([
                      TextCellValue(transaction.transactionId.toString()),
                      TextCellValue(productList
                          .firstWhere(
                              (element) => element.id == transaction.productId)
                          .title),
                      TextCellValue(
                          transaction.transactionTypeId == 1 ? 'إضافة' : 'سحب'),
                      TextCellValue(transaction.amount.toString()),
                      TextCellValue(transaction.notes.toString()),
                      TextCellValue(transaction.createdAt.toIso8601String()),
                    ]);
                  }

                  // Get the app's documents directory
                  final Directory? appDocDir =
                      await getExternalStorageDirectory();

                  // Define the Excel file path
                  final String excelPath = '${appDocDir!.path}/report.xlsx';

                  // Save the Excel file
                  final List<int>? bytes = excel.encode();
                  File(excelPath).writeAsBytesSync(Uint8List.fromList(bytes!));
                  print('Excel file saved at: $excelPath');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تم تصدير ملف'),
                    ),
                  );
                } catch (e) {
                  // Handle exceptions (e.g., log, show an error message, etc.)
                  print('Error exporting to Excel: $e');
                }
              },
              child: const Text('تصدير'),
            ),
            ToggleButtons(
              onPressed: (index) {
                print(index);
              },
              isSelected: [true, false, false, false],
              constraints: BoxConstraints(
                minHeight: 40,
                minWidth: 90,
              ),
              children: [
                Text('اليوم'),
                Text('الأسبوع'),
                Text('الشهر'),
                Text('مخصص'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
