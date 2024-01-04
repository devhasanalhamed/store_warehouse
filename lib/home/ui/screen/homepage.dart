import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:store_warehouse/core/database/dao/product_dao.dart';
import 'package:store_warehouse/core/database/dao/transaction_dao.dart';
import 'package:store_warehouse/core/utils/app_design.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesign.mediumPadding,
        vertical: AppDesign.smallPadding,
      ),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              TransactionDAO().fetchMostUsedProduct();
            },
            child: const Text('data'),
          ),
          Container(
            height: 190,
            width: double.infinity,
            padding: const EdgeInsets.all(AppDesign.smallPadding),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${DateTime.now().day}'.tr(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      Text(
                        DateFormat.yMd().format(DateTime.now()),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: PieChart(
                    dataMap: {
                      "add".tr(): 255,
                      "consume".tr(): 100,
                    },
                    colorList: const [
                      Color.fromARGB(255, 93, 236, 93),
                      Color.fromARGB(255, 243, 115, 115),
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppDesign.mediumPadding),
                  height: 190,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        AppDesign.circularRadius,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      FutureBuilder(
                        future: ProductDAO().fetchProductsCount(),
                        builder: (context, snapshot) {
                          {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else {
                              return const Text(
                                '.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          }
                        },
                      ),
                      Text(
                        'totalProducts'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppDesign.smallPadding),
              Expanded(
                child: SizedBox(
                  height: 190,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              AppDesign.circularRadius,
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder<Map<String, dynamic>>(
                        future: TransactionDAO().fetchMostUsedProduct(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  AppDesign.circularRadius,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.file(
                                    File(
                                      snapshot.data!['image_path'],
                                    ),
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    snapshot.data!['name'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
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
                        padding: const EdgeInsets.all(AppDesign.mediumPadding),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Colors.white.withOpacity(0.1),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              AppDesign.circularRadius,
                            ),
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
            ],
          )
        ],
      ),
    );
  }
}