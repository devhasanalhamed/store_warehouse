import 'dart:io';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:store_warehouse/core/database/dao/product_dao.dart';
import 'package:store_warehouse/core/database/dao/transaction_dao.dart';
import 'package:store_warehouse/core/constants/app_design.dart';
import 'package:store_warehouse/core/database/sql_helper.dart';
import 'package:store_warehouse/home/ui/widget/grid_element.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesign.mediumPadding,
        vertical: AppDesign.smallPadding,
      ),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaY: 100, sigmaX: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 50,
                        height: 100,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListView(
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
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${DateTime.now().weekday}'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          const SizedBox(height: AppDesign.smallPadding),
                          Text(
                            DateFormat.yMd().format(DateTime.now()),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: PieChart(
                        dataMap: {
                          "add".tr(): 0,
                          "consume".tr(): 0,
                        },
                        colorList: const [
                          Color(0xFF81F986),
                          Color(0xFFE85158),
                        ],
                        chartLegendSpacing: 32,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        initialAngleInDegree: 90,
                        chartType: ChartType.disc,
                        legendOptions: const LegendOptions(
                          showLegendsInRow: true,
                          legendPosition: LegendPosition.bottom,
                          showLegends: true,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                          decimalPlaces: 0,
                        ),
                        animationDuration: const Duration(milliseconds: 0),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: AppDesign.smallPadding),
              Row(
                children: [
                  GridElement(
                    title: 'totalProducts',
                    futureFunction: ProductDAO().fetchProductsCount(),
                  ),
                  const SizedBox(width: AppDesign.smallPadding),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF4C4C4C).withOpacity(0.1),
                        ),
                        borderRadius: BorderRadius.circular(
                          AppDesign.circularRadius,
                        ),
                      ),
                      height: 190,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            AppDesign.circularRadius,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            FutureBuilder<Map<String, dynamic>>(
                              future: TransactionDAO().fetchMostUsedProduct(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      if (File(
                                        snapshot.data!['image_path'],
                                      ).existsSync())
                                        Image.file(
                                          File(
                                            snapshot.data!['image_path'],
                                          ),
                                          height: double.infinity,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      FittedBox(
                                        child: Center(
                                          child: Container(
                                            padding: const EdgeInsets.all(
                                                AppDesign.smallPadding),
                                            decoration: const ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                    AppDesign.circularRadius,
                                                  ),
                                                ),
                                              ),
                                              color: Colors.white54,
                                            ),
                                            child: Text(
                                              snapshot.data!['name'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return SvgPicture.asset(
                                    'assets/svg/productPlaceHolder.svg',
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  );
                                }
                              },
                            ),
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              padding:
                                  const EdgeInsets.all(AppDesign.mediumPadding),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF4C4C4C),
                                    Colors.white.withOpacity(0.1),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'mostUsedProduct'.tr(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDesign.smallPadding),
              Row(
                children: [
                  GridElement(
                    title: 'lastBackup',
                    futureFunction: SQLHelper().getLastBackup(),
                    extendedColor: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: AppDesign.smallPadding),
                  GridElement(
                    title: 'lastTransaction',
                    futureFunction: ProductDAO().fetchProductsCount(),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
