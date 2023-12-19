import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';
import 'package:store_warehouse/report/logic/report_view_model.dart';
import 'package:store_warehouse/report/ui/widget/reports_list.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportViewModel>(
      builder: (_, state, __) => ListView(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          TextButton(
              onPressed: () => context.read<ReportViewModel>().getTodayReport(),
              child: const Text('button')),
          const ReportsList(),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDesign.smallPadding),
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
                      TableRow(children: [
                        Text(transaction.productId.toString()),
                        Text(transaction.transactionTypeId.toString()),
                        Text(transaction.amount.toString()),
                        Text(transaction.createdAt.toString()),
                        Text(transaction.notes.toString()),
                      ]),
                  ],
                ),
                Selector<ReportViewModel, int>(
                  selector: (_, toggleValue) => toggleValue.toggle,
                  builder: (_, value, __) => ToggleButtons(
                    isSelected: state.selectedToggle,
                    selectedColor: Theme.of(context).colorScheme.primary,
                    onPressed: (index) {
                      context.read<ReportViewModel>().updateToggle(index);
                    },
                    children: const [
                      Text('اليوم'),
                      Text('اسبوع'),
                      Text('شهر'),
                      Text('مخصص'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
