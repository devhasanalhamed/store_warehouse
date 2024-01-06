import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:store_warehouse/core/constants/app_design.dart';

class GridElement extends StatelessWidget {
  final String title;
  final Future<String> futureFunction;
  final Color? backgroundColor;
  const GridElement({
    Key? key,
    required this.title,
    required this.futureFunction,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppDesign.mediumPadding),
        height: 190,
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xFFC23C2A),
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
              title.tr(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
