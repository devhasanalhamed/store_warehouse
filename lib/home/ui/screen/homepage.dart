import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:store_warehouse/core/database/dao/product_dao.dart';
import 'package:store_warehouse/core/database/dao/transaction_dao.dart';
import 'package:store_warehouse/core/constants/app_design.dart';
import 'package:store_warehouse/core/database/sql_helper.dart';
import 'package:store_warehouse/home/ui/widget/grid_element.dart';
import 'package:store_warehouse/home/ui/widget/photo_grid_element.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesign.mediumPadding,
        vertical: AppDesign.smallPadding,
      ),
      child: ListView(
        children: [
          Container(
            height: 190,
            width: double.infinity,
            padding: const EdgeInsets.all(AppDesign.smallPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  AppDesign.circularRadius,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${DateTime.now().weekday}'.tr(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppDesign.smallPadding),
                    Text(
                      DateFormat.yMd().format(DateTime.now()),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDesign.smallPadding),
          Row(
            children: [
              GridElement(
                flex: 3,
                title: 'totalProducts',
                futureFunction: ProductDAO().fetchProductsCount(),
              ),
              const SizedBox(width: AppDesign.smallPadding),
              PhotoGridElement(
                title: 'mostUsedProduct',
                futureFunction: TransactionDAO().fetchMostUsedProduct(),
                flex: 5,
                child: true,
              ),
            ],
          ),
          const SizedBox(height: AppDesign.smallPadding),
          Row(
            children: [
              GridElement(
                title: 'lastBackup',
                flex: 4,
                futureFunction: SQLHelper().getLastBackup(),
                extendedColor: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: AppDesign.smallPadding),
              PhotoGridElement(
                title: 'lastTransaction',
                futureFunction: TransactionDAO().fetchLastTransaction(),
                flex: 3,
                child: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
