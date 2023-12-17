import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';
import 'package:store_warehouse/report/logic/report_view_model.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDesign.smallPadding),
      child: Consumer<ReportViewModel>(
        builder: (_, state, __) => ListView(
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
                        TableRow(children: [
                          Text(transaction.productId.toString()),
                          Text(transaction.transactionTypeId.toString()),
                          Text(transaction.amount.toString()),
                          Text(transaction.createdAt.toString()),
                          Text(transaction.notes.toString()),
                        ]),
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
                      const TextCellValue('Transaction ID'),
                      const TextCellValue('Product ID'),
                      const TextCellValue('Transaction Type'),
                      const TextCellValue('Amount'),
                      const TextCellValue('Notes'),
                      const TextCellValue('Created At')
                    ]);

                    // Add transaction data to the sheet
                    for (var transaction in state.todayReport) {
                      sheet.appendRow([
                        TextCellValue(transaction.transactionId.toString()),
                        TextCellValue(transaction.productId.toString()),
                        TextCellValue(transaction.transactionTypeId.toString()),
                        TextCellValue(transaction.amount.toString()),
                        TextCellValue(transaction.notes.toString()),
                        TextCellValue(transaction.createdAt.toIso8601String()),
                      ]);
                    }

                    // Get the app's documents directory
                    final Directory? appDocDir =
                        await getExternalStorageDirectory();

                    // Define the Excel file path
                    final String excelPath =
                        '${appDocDir!.path}/${DateTime.now().microsecond}_report.xlsx';

                    // Save the Excel file
                    final List<int>? bytes = excel.encode();
                    File(excelPath)
                        .writeAsBytesSync(Uint8List.fromList(bytes!));
                    print('Excel file saved at: $excelPath');
                  } catch (e) {
                    // Handle exceptions (e.g., log, show an error message, etc.)
                    print('Error exporting to Excel: $e');
                  }
                },
                child: const Text('تصدير')),
          ],
        ),
      ),
    );
  }
}
