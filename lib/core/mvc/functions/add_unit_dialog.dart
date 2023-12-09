import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/mvc/controller/unit_provider.dart';
import 'package:store_warehouse/core/mvc/view/widgets/elevated_button_component.dart';

addUnitDialog(BuildContext context) {
  String unitTitle = '';
  int unitPerPiece = 0;
  showDialog(
    context: context,
    builder: (s) => ClipRRect(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'إضافة وحدة جديدة',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('أسم الوحدة'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    isDense: true,
                  ),
                  onChanged: (value) => unitTitle = value,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('العدد بالحبة'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    isDense: true,
                  ),
                  onChanged: (value) => unitPerPiece = int.parse(value),
                ),
                const SizedBox(height: 16.0),
                ElevatedButtonComponent(
                  title: 'إضافة وحدة جديد',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
