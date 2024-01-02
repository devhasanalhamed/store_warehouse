import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';
import 'package:store_warehouse/report/logic/report_view_model.dart';
import 'package:store_warehouse/report/ui/widget/reports_list.dart';
import 'package:store_warehouse/shared/function/dialog/date_between_dialog.dart';
import 'package:store_warehouse/transaction/data/transaction_model.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ReportsList(),
          const SizedBox(height: 8.0),
          Selector<ReportViewModel, List<TransactionModel>>(
            selector: (_, state) => state.getReportList,
            builder: (_, getReportList, __) => SizedBox(
              height: 400,
              child: ListView(
                children: [
                  Table(
                    border: TableBorder.all(
                      color: Colors.green,
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      const TableRow(
                        children: [
                          Text(
                            'المنتج',
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'نوع العملية',
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'الكمية',
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'التاريخ',
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'الملاحظات',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      for (var transaction in getReportList)
                        TableRow(
                          children: [
                            Text(
                              productList
                                  .firstWhere((element) =>
                                      element.id == transaction.productId)
                                  .title,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              transaction.transactionTypeId == 1
                                  ? 'إضافة'
                                  : 'سحب',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              transaction.amount.toString(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              DateFormat('y-M-d | HH:MM')
                                  .format(transaction.createdAt),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              transaction.notes.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Consumer<ReportViewModel>(
            builder: (_, state, __) => ToggleButtons(
              onPressed: (index) async {
                if (index == 3) {
                  await dateBetweenDialog(context);
                } else {
                  state.updateReportType(index);
                }
              },
              isSelected: state.toggleBoolean,
              constraints: const BoxConstraints(
                minHeight: 40,
                minWidth: 90,
              ),
              children: const [
                Text('اليوم'),
                Text('الأسبوع'),
                Text('الشهر'),
                Text('مخصص'),
              ],
            ),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}
