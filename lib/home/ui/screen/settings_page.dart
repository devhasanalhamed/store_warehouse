import 'package:flutter/material.dart';
import 'package:store_warehouse/core/database/db_config.dart';
import 'package:store_warehouse/core/database/sql_helper.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          onTap: () => DbConfig.delete(),
          title: const Text('delete database'),
        ),
        ListTile(
          onTap: () => SQLHelper().backupDB().then((value) =>
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    const SnackBar(content: Text('تم نسخ قاعدة البيانات')))),
          title: const Text('نسخ احتياطي'),
        ),
        const Divider(),
        ListTile(
          onTap: () => SQLHelper().restoreDB().then((value) =>
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    const SnackBar(content: Text('أعد تشغيل التطبيق')))),
          title: const Text('استيراد قاعدة بيانات'),
        ),
        const Divider(),
      ],
    );
  }
}
