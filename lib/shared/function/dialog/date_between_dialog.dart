import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/constants/app_design.dart';
import 'package:store_warehouse/report/logic/report_view_model.dart';

dateBetweenDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        TextEditingController startDateController = TextEditingController();
        TextEditingController endDateController = TextEditingController();
        late DateTime startDate;
        late DateTime endDate;
        return Dialog(
          child: Container(
            padding: const EdgeInsets.only(
              left: AppDesign.smallPadding,
              top: 16.0,
              right: AppDesign.smallPadding,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                AppDesign.circularRadius,
              ),
            ),
            width: 300,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                    controller: startDateController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('التاريخ من:'),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final value = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 4),
                        lastDate: DateTime(DateTime.now().year + 4),
                      );
                      if (value == null) return;
                      startDate = value;
                      startDateController.text =
                          '${value.day}-${value.month}-${value.year}';
                    }),
                const SizedBox(height: AppDesign.mediumPadding),
                TextFormField(
                    controller: endDateController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('التاريخ إلى:'),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final value = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 4),
                        lastDate: DateTime(DateTime.now().year + 4),
                      );
                      if (value == null) return;
                      endDate = value;
                      endDateController.text =
                          '${value.day}-${value.month}-${value.year}';
                    }),
                ElevatedButton(
                  onPressed: () {
                    context.read<ReportViewModel>().updateReportType(3);
                    context
                        .read<ReportViewModel>()
                        .getCustomReport(startDate, endDate);
                    Navigator.pop(context);
                  },
                  child: const Text('موافق'),
                )
              ],
            ),
          ),
        );
      },
    );
