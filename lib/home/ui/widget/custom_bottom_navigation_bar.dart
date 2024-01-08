// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:store_warehouse/core/constants/app_string.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.white60,
      elevation: 0.0,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: AppString.products,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.swap_horiz),
          label: AppString.transactions,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppString.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_open),
          label: AppString.reports,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: AppString.settings,
        ),
      ],
    );
  }
}
