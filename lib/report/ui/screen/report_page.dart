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
                      for (var transaction in getReportList)
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
                            Text(
                              DateFormat('y-M-d | HH:MM')
                                  .format(transaction.createdAt),
                            ),
                            Text(transaction.notes.toString()),
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
        ],
      ),
    );
  }
}
