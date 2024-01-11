import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:store_warehouse/core/constants/app_design.dart';

class GridElement extends StatelessWidget {
  final String title;
  final Future<String> futureFunction;
  final Color? extendedColor;
  final int flex;
  const GridElement({
    Key? key,
    required this.title,
    required this.futureFunction,
    this.extendedColor,
    this.flex = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(AppDesign.mediumPadding),
        height: 190,
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: const BorderRadius.all(
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
              future: futureFunction,
              builder: (context, snapshot) {
                {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  } else {
                    return Text(
                      '.',
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  }
                }
              },
            ),
            FittedBox(
              child: Text(
                title.tr(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: extendedColor ?? const Color(0xFF4C4C4C),
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
