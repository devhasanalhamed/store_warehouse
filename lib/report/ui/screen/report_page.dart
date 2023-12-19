import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';
import 'package:store_warehouse/product/logic/product_view_model.dart';
import 'package:store_warehouse/report/logic/report_view_model.dart';
import 'package:store_warehouse/report/ui/widget/reports_list.dart';

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
            const ReportsList(),
            Text(state.reportType.name),
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
                      for (var transaction in state.getReportList)
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
            ToggleButtons(
              onPressed: (index) {
                state.updateReportType(index);
                state.getReportFunction;
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
          ],
        ),
      ),
    );
  }
}
