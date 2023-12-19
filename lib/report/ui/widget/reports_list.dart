import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';
import 'package:store_warehouse/report/logic/report_view_model.dart';
import 'package:store_warehouse/shared/function/dialog/delete_confirm.dart';

class ReportsList extends StatelessWidget {
  const ReportsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ReportViewModel, List<Map<String, dynamic>>>(
      selector: (_, state) => state.reportFiles,
      builder: (_, reportFiles, __) => Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDesign.smallPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Text(
                      'آخر التقارير',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(width: 4.0),
                    Icon(
                      Icons.bar_chart,
                      size: 24.0,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  ],
                ),
                TextButton(
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  child: const Text('الكل'),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade100,
            height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDesign.smallPadding),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: AppDesign.smallPadding),
                itemCount: reportFiles.length,
                itemBuilder: (context, index) => InkWell(
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: AppDesign.smallPadding),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius:
                          BorderRadius.circular(AppDesign.circularRadius),
                    ),
                    child: ListTile(
                      onTap: () => OpenFile.open(reportFiles[index]['path']),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                      ),
                      title: FittedBox(child: Text(reportFiles[index]['name'])),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Text(
                          'xlsx',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.share),
                            ),
                            IconButton(
                              onPressed: () async {
                                final delete =
                                    await deleteConfirmDialog(context);
                                if (delete) {
                                  File(reportFiles[index]['path'])
                                      .delete()
                                      .then((value) => context
                                          .read<ReportViewModel>()
                                          .getReportFiles());
                                }
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
